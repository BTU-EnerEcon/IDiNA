

profil(t) = load_up(t,'profil');

sLmax_scaled(l)$(ord(l) gt 1) = (sum(t, sLmax(l,t)/1000)/96);
sLmax_scaled(l)$(ord(l) eq 1) = (sum(t, sLmax(l,t)/1000)/96);

Load_bus_ref(b) = load_up_b(b,'Active demand');
Load_bus_ref_t(b,t) = Load_bus_ref(b) * profil(t);

   
if(ord(it) eq 1,  
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_01(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
  
elseif ord(it) eq 2,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_02(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
$ontext     
elseif ord(it) eq 3,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_03(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
    
elseif ord(it) eq 4,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_04(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
    
elseif ord(it) eq 5,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_05(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
            
elseif ord(it) eq 6,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_06(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
    
elseif ord(it) eq 7,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_07(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
    
elseif ord(it) eq 8,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_08(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
    
elseif ord(it) eq 9,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_09(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
              
elseif ord(it) eq 10,
     

    Load_bus_t(b,s,t) = Load_bus(b) * profil_10(t,s)
    ;
    Load_deviation(b,s,t) = Load_bus_t(b,s,t) - Load_bus_ref_t(b,t)
    ;
$offtext              
)
;


*in MW
PF_result(s,l,t) = (pl(l,t) + sum(b, Load_deviation(b,s,t) * PTDF_PBPK(l,b,t) *1000000))/1000000  
;
*in kV
Vl(b,t) = (sqrt(uki(b,t)*uki(b,t) + ukr(b,t)*ukr(b,t)))/1000
;
VL_result(s,b,t) = Vl(b,t) + sum(bb, Load_deviation(b,s,t) * (1000 *(-1)*PTDF_UKPK(b,bb,t)))
;
Line_Violation_test(s,l,t) = PF_result(s,l,t) - sLmax_scaled(l)
;
Voltage_violation_up(s,b,t)$((VL_result(s,b,t)*1000 - ukn(b,t)*1.05) gt 0) = VL_result(s,b,t)*1000 - (ukn(b,t)*1.05)
;
Voltage_violation_lo(s,b,t)$((ukn(b,t)*0.95 - VL_result(s,b,t)*1000) gt 0) = (ukn(b,t)*0.95) - VL_result(s,b,t)*1000
;
