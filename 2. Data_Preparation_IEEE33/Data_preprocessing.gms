Set
   t                           / 1*8760    /
   b        'network buses'    / 1*33    /
   l        'lines'            / 1*35   /
   g        'dispatchable generating units' / 1*5   /
   p        'solar photovoltaik generators' /1*4  /
   s        'scenarios'        / 1*1000/
   slack(b)                    / 1       /
   Map_G(b,g)/1.1, 18.2, 22.3, 25.4,33.5/
   Map_PV(b,p) /18.1, 22.2, 25.3, 33.4/
   
  it /1/
;
alias (b,bb)
;
Parameter
Base_load(b)
Base_load_time_series(t,b)

RH_Error_SLP(s,t,b)
RH_Error_ARIMA(s,t,b)
RH_Load_deviation(s,t,b)

PTDF_PBPK(l,b,t)
PTDF_PBQK(l,b,t)
pl(l,t)
PF_result(s,l,t)

sLmax_scaled(l)
slmax(l,t)


uki(b,t)
ukr(b,t)
ukn(b,t)

Vl(b,t)
VL_result(s,b,t)
PTDF_UKPK(b,bb,t)
PTDF_UKQK(b,bb,t)

Line_Violation_test(s,l,t)
Voltage_violation_up(s,b,t)
Voltage_violation_lo(s,b,t)

;
$onecho > TEP.txt
par=Base_load                 rng=data_case_study!A8765:B8797                            rDim=1 cdim=0
par=Base_load_time_series     rng=data_case_study!G2:AN8762                              rDim=1 cdim=1      
$offecho
;
$onUNDF
$call   gdxxrw data_case33.xlsx @TEP.txt
$GDXin  data_case33.gdx
$load   Base_load,Base_load_time_series
$GDXin
$offUNDF
;
$onecho > TEP.txt
par=RH_Error_SLP                 rng=sheet1!A1:AI96001                            rDim=2 cdim=1                   
$offecho
;
$onUNDF
$call   gdxxrw Load_deviation_SLP.xlsx @TEP.txt
$GDXin  Load_deviation_SLP.gdx
$load   RH_Error_SLP
$GDXin
$offUNDF
;
$GDXin   AC_IEEE_Case_study.gdx
$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK
;

RH_Load_deviation(s,t,b) = Base_load(b) * RH_Error_SLP(s,t,b)  - Base_load(b) * Base_load_time_series(t,b)
;


sLmax_scaled(l)$(ord(l) gt 1) = (sum(t, sLmax(l,t)/1000)/8760);
sLmax_scaled(l)$(ord(l) eq 1) = (sum(t, sLmax(l,t)/1000)/8760);

*in MW
PF_result(s,l,t) = (pl(l,t) + sum(b, RH_Load_deviation(s,t,b) * PTDF_PBPK(l,b,t) *1000000))/1000000  
;
*in kV
Vl(b,t) = (sqrt(uki(b,t)*uki(b,t) + ukr(b,t)*ukr(b,t)))/1000
;
VL_result(s,b,t) = Vl(b,t) + sum(bb, RH_Load_deviation(s,t,b) * (1000 *PTDF_UKPK(b,bb,t)))
;
Line_Violation_test(s,l,t) = PF_result(s,l,t) - sLmax_scaled(l)
;
Voltage_violation_up(s,b,t)$((VL_result(s,b,t)*1000 - ukn(b,t)*1.05) gt 0) = VL_result(s,b,t)*1000 - (ukn(b,t)*1.05)
;
Voltage_violation_lo(s,b,t)$((ukn(b,t)*0.95 - VL_result(s,b,t)*1000) gt 0) = (ukn(b,t)*0.95) - VL_result(s,b,t)*1000
;
execute_unload "Load_deviation_data.gdx"
;
execute 'gdxxrw.exe Load_deviation_data.gdx o=PF_Data_SLP.xlsx par=PF_result'
;
execute 'gdxxrw.exe Load_deviation_data.gdx o=VL_Data_SLP.xlsx par=VL_result'
$stop
