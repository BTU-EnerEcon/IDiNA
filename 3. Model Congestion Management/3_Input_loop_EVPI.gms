


sLmax_scaled(l)$(ord(l) gt 1) = (sum(t, sLmax(l,t)/1000)/96);
sLmax_scaled(l)$(ord(l) eq 1) = (sum(t, sLmax(l,t)/1000)/96);
   
if(ord(it) eq 1,  
     
PF_result(s,l,t) = IN_PF_EVPI_01(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_01(s,b,t)
;

$ontext 
elseif ord(it) eq 2,
     

PF_result(s,l,t) = IN_PF_EVPI_02(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_02(s,b,t)
;
    
elseif ord(it) eq 3,
     

PF_result(s,l,t) = IN_PF_EVPI_03(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_03(s,b,t)
;

elseif ord(it) eq 4,
     

PF_result(s,l,t) = IN_PF_EVPI_04(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_04(s,b,t)
;

    
elseif ord(it) eq 5,
     

PF_result(s,l,t) = IN_PF_EVPI_05(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_05(s,b,t)
;

            
elseif ord(it) eq 6,
     

PF_result(s,l,t) = IN_PF_EVPI_06(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_06(s,b,t)
;

elseif ord(it) eq 7,
     

PF_result(s,l,t) = IN_PF_EVPI_07(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_07(s,b,t)
;

elseif ord(it) eq 8,
     

PF_result(s,l,t) = IN_PF_EVPI_08(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_08(s,b,t)
;

elseif ord(it) eq 9,
     

PF_result(s,l,t) = IN_PF_EVPI_09(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_09(s,b,t)
;
        
elseif ord(it) eq 10,
     

PF_result(s,l,t) = IN_PF_EVPI_10(s,l,t)
;
VL_result(s,b,t)= IN_VL_EVPI_10(s,b,t)
;

$offtext              
)
;


*in kV
Vl(b,t) = (sqrt(uki(b,t)*uki(b,t) + ukr(b,t)*ukr(b,t)))/1000
;
Line_Violation_test(s,l,t) = PF_result(s,l,t) - sLmax_scaled(l)
;
Voltage_violation_up(s,b,t)$((VL_result(s,b,t)*1000 - ukn(b,t)*1.05) gt 0) = VL_result(s,b,t)*1000 - (ukn(b,t)*1.05)
;
Voltage_violation_lo(s,b,t)$((ukn(b,t)*0.95 - VL_result(s,b,t)*1000) gt 0) = (ukn(b,t)*0.95) - VL_result(s,b,t)*1000
;
