

sLmax_scaled(l)$(ord(l) gt 1) = (sum(t, sLmax(l,t)/1000)/8760);
sLmax_scaled(l)$(ord(l) eq 1) = (sum(t, sLmax(l,t)/1000)/8760);
   
   
PF_result(l,t) = IN_PF_max(l,t) * 1000000
;
VL_result(b,t)= IN_VL_max(b,t)
;


*in kV
Vl(b,t) = (sqrt(uki(b,t)*uki(b,t) + ukr(b,t)*ukr(b,t)))/1000
;
Line_Violation_test(l,t) = PF_result(l,t) - sLmax_scaled(l)
;
Voltage_violation_up(b,t)$((VL_result(b,t)*1000 - ukn(b,t)*1.05) gt 0) = VL_result(b,t)*1000 - (ukn(b,t)*1.05)
;
Voltage_violation_lo(b,t)$((ukn(b,t)*0.95 - VL_result(b,t)*1000) gt 0) = (ukn(b,t)*0.95) - VL_result(b,t)*1000
;
