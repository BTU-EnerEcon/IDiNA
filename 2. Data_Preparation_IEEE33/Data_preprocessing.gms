Set
   t                           / 1*96    /
   b        'network buses'    / 1*33    /
   l        'lines'            / 1*35   /
   g        'dispatchable generating units' / 1*5   /
   p        'solar photovoltaik generators' /1*4  /
   s        'scenarios'        / s1*s1000/
   slack(b)                    / 1       /
   Map_G(b,g)/1.1, 18.2, 22.3, 25.4,33.5/
   Map_PV(b,p) /18.1, 22.2, 25.3, 33.4/
   
  it /1/
;
alias (b,bb)
;
Parameter
Load_deviation(s,t,b)
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
par=Load_deviation                 rng=sheet1!A1:AI96001                            rDim=2 cdim=1                   
$offecho
;
$onUNDF
$call   gdxxrw Load_deviation_data.xlsx @TEP.txt
$GDXin  Load_deviation_data.gdx
$load   Load_deviation
$GDXin
$offUNDF


*$GDXin   AC_IEEE_Spring_hpv.gdx
*$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK
*;
*$GDXin   AC_IEEE_Summer_hpv.gdx
*$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK
*;
*$GDXin   AC_IEEE_Fall_hpv.gdx
*$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK
;
$GDXin   AC_IEEE_Winter_hpv.gdx
$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK
;


sLmax_scaled(l)$(ord(l) gt 1) = (sum(t, sLmax(l,t)/1000)/96);
sLmax_scaled(l)$(ord(l) eq 1) = (sum(t, sLmax(l,t)/1000)/96);

*in MW
PF_result(s,l,t) = (pl(l,t) + sum(b, Load_deviation(s,t,b) * PTDF_PBPK(l,b,t) *1000000))/1000000  
;
*in kV
Vl(b,t) = (sqrt(uki(b,t)*uki(b,t) + ukr(b,t)*ukr(b,t)))/1000
;
VL_result(s,b,t) = Vl(b,t) + sum(bb, Load_deviation(s,t,b) * (1000 *PTDF_UKPK(b,bb,t)))
;
Line_Violation_test(s,l,t) = PF_result(s,l,t) - sLmax_scaled(l)
;
Voltage_violation_up(s,b,t)$((VL_result(s,b,t)*1000 - ukn(b,t)*1.05) gt 0) = VL_result(s,b,t)*1000 - (ukn(b,t)*1.05)
;
Voltage_violation_lo(s,b,t)$((ukn(b,t)*0.95 - VL_result(s,b,t)*1000) gt 0) = (ukn(b,t)*0.95) - VL_result(s,b,t)*1000
;
execute_unload "Data.gdx"
;
execute 'gdxxrw.exe Data.gdx o=PF_Data_w_hpv_10.xlsx par=PF_result'
;
execute 'gdxxrw.exe Data.gdx o=VL_Data_w_hpv_10.xlsx par=VL_result'
$stop
