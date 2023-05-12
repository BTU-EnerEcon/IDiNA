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


Parameter
load_up

load_up_b
load_p(t)
load_q(t)
CF(t)

MP_DH(t)
profil(t)

BP(b)
BQ(b)
D_genP(g,t)
pv_infeed(b,t)

Load_bus_p(b,t)
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
par=load_up                        rng=data_case_study!A1:E8761                    rDim=1 cdim=1
par=Load_bus_p                     rng=data_case_study!G2:AN8762                    rDim=1 cdim=1
par=Load_bus_q                     rng=data_case_study!AP2:BW8762                    rDim=1 cdim=1
$offecho
*par=load_up                        rng=data!B16:H112                    rDim=1 cdim=1 winter

$onUNDF
$call   gdxxrw data_case33.xlsx @TEP.txt
$GDXin  data_case33.gdx
$load   load_up, Load_bus_p, Load_bus_q
$GDXin
$offUNDF
;
MP_DH(t)  = load_up(t,'Day_ahead_price')
;



%on_SLP%$Ontext
;
$onecho > PF.txt
par=IN_PF_max                   rng=Sheet1!A1:LXY33                      rDim=1 cdim=1                
$offecho
$onUNDF
$call   gdxxrw I=%SLP%PF_Data_SLP_Q95.xlsx O=%SLP%PF_Data_SLP_Q95.gdx @PF.txt
$GDXin  %SLP%PF_Data_SLP_Q95.gdx
$load   IN_PF_max

$GDXin
$offUNDF
;
$onecho > VL.txt
par=IN_VL_max                    rng=Sheet1!A1:LXY34                       rDim=1 cdim=1          
$offecho
$onUNDF
$call   gdxxrw I=%SLP%VL_Data_SLP_Q95.xlsx O=%SLP%VL_Data_SLP_Q95.gdx @VL.txt
$GDXin  %SLP%VL_Data_SLP_Q95.gdx
$load   IN_VL_max

$GDXin
$offUndf
;

$GDXin   IEEE_Case_study.gdx
$load    D_genP, pv_infeed, CF
*, load_up_b


$GDXin   AC_IEEE_Case_study.gdx
$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK

;
$ontext
$offtext


*###########################################################################################################

%on_ARIMA%$Ontext
;
$onecho > PF.txt
par=IN_PF_max                   rng=Tabelle1!A1:CT31001                      rDim=2 cdim=1               
$offecho
$onUNDF
$call   gdxxrw I=%ARIMA%PF_Data_ARIMA_Q95.xlsx O=%ARIMA%PF_Data_ARIMA_Q95.gdx @PF.txt
$GDXin  %ARIMA%PF_Data_ARIMA_Q95.gdx
$load   IN_PF_max_ARIMA
$GDXin
$offUNDF
;
$onecho > VL.txt
par=IN_VL_max                        rng=Tabelle1!A1:CT33001                       rDim=2 cdim=1            
$offecho
$onUNDF
$call   gdxxrw I=%ARIMA%VL_Data_ARIMA_Q95.xlsx O=%ARIMA%VL_Data_ARIMA_Q95.gdx @VL.txt
$GDXin  %ARIMA%VL_Data_ARIMA_Q95.gdx
$load   IN_VL_max_ARIMA
$GDXin
$offUndf
;

$GDXin   IEEE_Case_study.gdx
$load    D_genP, pv_infeed, CF, load_up
*, load_up_b


$GDXin   AC_IEEE_Case_study.gdx
$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK
;

$ontext
$offtext
*###########################################################################################################

%on_Normal%$Ontext
;
$onecho > PF.txt
par=IN_PF_max                   rng=Tabelle1!A1:CT31001                      rDim=2 cdim=1               
$offecho
$onUNDF
$call   gdxxrw I=%Normal%PF_Data_Q95.xlsx O=%Normal%PF_Data_Q95.gdx @PF.txt
$GDXin  %Normal%PF_Data_Q95.gdx
$load   IN_PF_max_Normal
$offUNDF
;
$onecho > VL.txt
par=IN_VL_max                        rng=Tabelle1!A1:CT33001                       rDim=2 cdim=1         
$offecho
$onUNDF
$call   gdxxrw I=%Normal%VL_Data_Q95.xlsx O=%Normal%VL_Data_Q95.gdx @VL.txt
$GDXin  %Normal%VL_Data_Q95.gdx
$load   IN_VL_max_Normal
$GDXin
$offUndf
;

$GDXin   IEEE_Case_study.gdx
$load    D_genP, pv_infeed, CF, load_up, load_up_b


$GDXin   AC_IEEE_Case_study.gdx
$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK

$ontext
$offtext
*Load_bus(b) = load_up_b(b,'Active Demand')
*;


