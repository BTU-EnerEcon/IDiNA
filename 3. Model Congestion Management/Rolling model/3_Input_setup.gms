Table GenD(g,*) 'generating units characteristics'

    pmax    pmin    Qmax    Qmin   var
1     4       0      2.5     -2.5   12 
2    0.2      0       0      0      10.26
3    0.2      0       0      0      10.26
4    0.2      0       0      0      10.26
5    0.2      0       0      0      10.26

;

Table GenPV(p,*) 'generating units characteristics'
      pmax 
1    0.2
2    0.2
3    0.2
4    0.2
;

Scalar
*in EUR/MWh
Flex_price /20/
annualized_inv_cost_SM /0.08/

*in EUR/MVAR
reactive_power_costs /0/
*25

AVG_MP /98/
;

Parameter
load_up

load_up_b
load_p(t)
load_q(t)
CF(t)

consumers(b)
Load_per_consumer(b,t)
max_load_per_consumer(b)


MP_DH(t)
profil(t)

BP(b)
BQ(b)
D_genP(g,t)
pv_infeed(b,t)

Load_bus_p(t,b)
load_bus_t(b,t)

Load_bus_q(b,t)
Load_deviation(b,t)

sl(l,t)
sLmax(l,t)
sLmax_scaled(l)
pl(l,t)
PF_result(l,t)

IN_PF_max(l,t)


PTDF_PBPK(l,b,t)
PTDF_PBQK(l,b,t)
Line_Violation_test(l,t)

uki(b,t)
ukr(b,t)
ukn(b,t)
Vl(b,t)
PTDF_UKPK(b,bb,t)
PTDF_UKQK(b,bb,t)
VL_result(b,t)

IN_VL_max(b,t)


Voltage_violation_up(b,t)
Voltage_violation_lo(b,t)

$onecho > TEP.txt
par=load_up                        rng=data_case_study!A1:E8761                     rDim=1 cdim=1
par=Load_bus_p                     rng=data_case_study!G2:AN8762                    rDim=1 cdim=1
par=Load_bus_q                     rng=data_case_study!AP2:BW8762                   rDim=1 cdim=1
par=consumers                      rng=Merged_SM!A1:B33                             rDim=1 cdim=0
$offecho

$onUNDF
$call   gdxxrw data_case33.xlsx @TEP.txt
$GDXin  data_case33.gdx
$load   load_up, Load_bus_p, Load_bus_q, consumers
$GDXin
$offUNDF
;
MP_DH(t)  = load_up(t,'Day_ahead_price')
;
*from KW in W
load_bus_t(b,t) = Load_bus_p(t,b) * 1000
;
load_per_consumer(b,t)$(ord(b) gt 1) = load_bus_t(b,t) / consumers(b)
;
max_load_per_consumer(b) = smax(t, load_per_consumer(b,t))
;

*###########################################################################################################
* read in x% quantil power flows and voltage levels from existing gdi file 

$GDXin  2_Uniform_Rollout_1
$load   IN_PF_max, IN_VL_max, D_genP, pv_infeed, CF,pl,slmax,sl, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK


* read in x% quantil power flows and voltage levels from xlsx files
%on_Rollout%$Ontext
;
$onecho > PF.txt
par=IN_PF_max                   rng=Sheet1!A1:LXY33                      rDim=1 cdim=1               
$offecho
$onUNDF
$call   gdxxrw I=%Rollout%result_PF_No_Rollout.xlsx O=%Rollout%result_PF_No_Rollout.gdx @PF.txt
$GDXin  %Rollout%result_PF_No_Rollout.gdx
$load   IN_PF_max
$GDXin
$offUNDF
;
*%ARIMA%PF_Data_ARIMA_Q95
$onecho > VL.txt
par=IN_VL_max                        rng=Sheet1!A1:LXY34                       rDim=1 cdim=1            
$offecho
$onUNDF
$call   gdxxrw I=%Rollout%result_VL_No_Rollout.xlsx O=%Rollout%result_VL_No_Rollout.gdx @VL.txt
$GDXin  %Rollout%result_VL_No_Rollout.gdx
$load   IN_VL_max
$GDXin
$offUndf
;
*%ARIMA%VL_Data_ARIMA_Q95
$GDXin   IEEE_Case_study.gdx
$load    D_genP, pv_infeed, CF
*, load_up_b


$GDXin   AC_IEEE_Case_study.gdx
$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK
;
$ontext
$offtext




