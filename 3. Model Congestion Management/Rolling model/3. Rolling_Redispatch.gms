$setglobal    on_Rollout "*"      if "*" xlsx input is readed, else ""
;
$set Rollout                "folder_name_from_pf&vl_xlsx_files"/


Set
   t                           / 1*8760    /
   b        'network buses'    / 1*33    /
   l        'lines'            / 1*35   /
   g        'dispatchable generating units' / 1*5   /
   p        'solar photovoltaik generators' /1*4  /
   s        'scenarios'        / s1*s100/
   slack(b)                    / 1       /
   Map_G(b,g)/1.1, 18.2, 22.3, 25.4,33.5/
   Map_PV(b,p) /18.1, 22.2, 25.3, 33.4/
   
  it /1*365/

  rh(t)
;
Scalar
   Sbase /   100 /
   VOLL  / 10000 /
   VOLW  /    50 /
   Scale_to_W /1000000000/
   Line_cap_scale /0/;

Alias (b,bb), (it,iitt)
;

************************************Loading Data****************************************
$include 3_input_setup.gms
;
****************************************************************************************
Variables
RD_OF              objective funktion value to be minimized (total costs)
adjust_Pij(l,t)    adjusted active powerflow (current in A)  
RD_V(b,t)          Voltage magnitude in bus i at time t (pu)
;

positive variables
RD_Pg(it,g,t)           Resulting active power generation
RD_Pg_up(g,t)           Active power increase due to redispatch by thermal unit g connected to bus i at time t (MW). Wirkleistungserzeugung thermisch
RD_Pg_down(g,t)         Active power decrease due to redispatch by thermal unit g connected to bus i at time t (MW). Wirkleistungserzeugung thermisch
RD_dem_resp_down(b,t)   positive active power Demand response (reduction of load)
RD_dem_resp_up(b,t)     negative active power Demand response (increase of of load)

RD_Qg_pos(g,t)           Resulting positive reactive power redispatch from conventional generators
RD_Qg_neg(g,t)           Resulting negative reactive power redispatch from conventional generators
RD_Qpv_pos(p,t)          Resulting positive reactive power redispatch from PV plants
RD_Qpv_neg(p,t)          Resulting positive reactive power redispatch from PV plants

violation(l,t)

adjust_v(b,t)

*RD_Qg_up(g,t)     Reactive power increase due to redispatch by thermal unit g connected to bus i at time t (MW). Blindleistungserzeugung thermisch
*RD_Qg_down(g,t)   Reactive power decrease due to redispatch by thermal unit g connected to bus i at time t (MW). Blindleistungserzeugung thermisch
RD_curtail(b,t)
RD_LS(it,b,t)
;

Equation
RD_eq1,
RD_eq2a, RD_eq2b
RD_eq3,
RD_eq4, 
RD_eq5,
RD_eq6,
RD_eq7,
RD_eq8,
RD_eq9,
RD_eq10,
RD_eq11,
RD_eq12
RD_eq13
;

*#########################################Redispatch###################################################


RD_eq1..                            RD_OF  =e=

                                    + sum((g,t)$rh(t), RD_Pg_up(g,t)  * GenD(g,'var')/1000000)
                                    + sum((g,t)$rh(t), (RD_Pg_down(g,t) ) * (MP_DH(t) - GenD(g,'var'))/1000000)
                                    
                                    + sum((g,t)$rh(t), RD_Qg_pos(g,t) * MP_DH(t)/1000000)
                                    + sum((g,t)$rh(t), RD_Qg_neg(g,t) * MP_DH(t)/1000000)
                                    + sum((p,t)$rh(t), RD_Qpv_pos(p,t) * MP_DH(t)/1000000)
                                    + sum((p,t)$rh(t), RD_Qpv_neg(p,t) * MP_DH(t)/1000000)
                                    
                                    + sum((b,t)$rh(t), RD_dem_resp_down(b,t) * Flex_price/1000000)
                                    + sum((b,t)$rh(t), RD_dem_resp_up(b,t) * Flex_price/1000000)
                                    + sum((b,t)$rh(t), RD_curtail(b,t) * MP_DH(t)/1000000)
                                                              
                                    + sum((l,t)$rh(t),  violation(l,t) * 1000000)
;                                 

*adjusted wirkleistungs powerflow from i to j on line l due to congestion management actions

RD_eq2a(l,t)$rh(t)..                adjust_Pij(l,t)  =e= PF_result(l,t)
                                    + sum((b),  ((1) * PTDF_PBPK(l,b,t)) * (sum(g$Map_G(b,g), - RD_Pg_up(g,t) + RD_Pg_down(g,t))
                                    + RD_curtail(b,t)
                                    - RD_dem_resp_down(b,t)
                                    + RD_dem_resp_up(b,t)
                                    )
                                    )
                                    + sum((b),  ((1) * PTDF_PBQK(l,b,t)) * (sum(g$Map_G(b,g), - RD_Qg_pos(g,t) + RD_Qg_neg(g,t))
                                    +  sum(p$Map_PV(b,p), - RD_Qpv_pos(p,t) + RD_Qpv_neg(p,t))))
                                    
;


*adjusted voltage level at node i due to congestion management actions

RD_eq2b(bb,t)$rh(t)..               adjust_v(bb,t)  =e= VL_result(bb,t) 
                                    + sum(b, ((1) * PTDF_UKPK(b,bb,t)) * (sum(g$Map_G(b,g), - RD_Pg_up(g,t) + RD_Pg_down(g,t))
                                    + RD_curtail(b,t)
                                    - RD_dem_resp_down(b,t)
                                    + RD_dem_resp_up(b,t)
                                    )
                                    )
                                    + sum(b, ((1) * PTDF_UKQK(b,bb,t)) * (sum(g$Map_G(b,g), - RD_Qg_pos(g,t) + RD_Qg_neg(g,t))
                                    +  sum(p$Map_PV(b,p), - RD_Qpv_pos(p,t) + RD_Qpv_neg(p,t))))
                                    
;
                               

*Thermal power flow limitations of lines (current in A)
RD_eq3(l,t)$rh(t)..                       adjust_Pij(l,t)  =l= (sLmax_scaled(l)  + sLmax_scaled(l) * Line_cap_scale) +  violation(l,t)
;

RD_eq4(l,t)$rh(t)..                       adjust_Pij(l,t)  =g= - (sLmax_scaled(l)  + sLmax_scaled(l) * Line_cap_scale) + ( -  violation(l,t))
;

*Volatage level limitations of lines in kV

RD_eq5(b,t)$rh(t)..                       adjust_v(b,t)  =l= ukn(b,t)*1.05 
;

RD_eq6(b,t)$rh(t)..                       adjust_v(b,t)  =g= ukn(b,t)*0.95 
;

* active Redispatch positive active demand response constraint

RD_eq7(b,t)$(rh(t) and ord(b) gt 1)..     RD_dem_resp_down(b,t) =l= 0
;

* active Redispatch negative demand response constraint

RD_eq8(b,t)$(rh(t) and ord(b) gt 1)..     RD_dem_resp_up(b,t) =l= 0
;
* active Redispatch Ramping up constraint 

RD_eq9(g,t)$rh(t)..                       RD_Pg_up(g,t)   =l= GenD(g,'pmax') * Scale_to_W - D_genP(g,t) * Scale_to_W
;
   
* active Redispatch Ramping down constraint 2 

RD_eq10(g,t)$rh(t)..                       RD_Pg_down(g,t) =l= D_genP(g,t) * Scale_to_W
;


* active Redispatch Curtailment

RD_eq11(b,t)$rh(t)..                       RD_curtail(b,t) =l=  pv_infeed(b,t) * Scale_to_W
;


RD_eq12(b)..                               y_SM(b) =l=  consumers(b)
;

RD_eq13..                                  0 =e=  sum((b,t), RD_dem_resp_down(b,t) + RD_dem_resp_up(b,t))
;

*###############################Model definition############################################  
**********************************************************


Model Redispatch / RD_eq1, RD_eq2a, RD_eq2b, RD_eq3, RD_eq4, RD_eq5, RD_eq6, RD_eq7, RD_eq8, RD_eq9, RD_eq10, RD_eq11/ ;

*****************************output parameter declaration
Parameter
report(t,g,*)
D_injection(b,t)
D_draw(b,t)
D_saldo(b,t)
report3(g,t)
report4(g,t)
lmp(b,t)
report_violation(it,l,t)
Report_curtail(it,b,t)
Report_PG_up(it,g,t)
Report_PG_down(it,g,t)
Report_dem_resp_down(it,b,t)
Report_dem_resp_up(it,b,t)
Report_RD_costs(it)
Report_RD_bus_costs(it,b)
Uncertain_line_flow(l,t)
Report_reactive_compensation(it,g,t)
Report_Total_Curtail
Report_Total_Redispatch_up
Report_Total_Redispatch_down
Report_Total_Reactive_Compensation
Report_Total_RD_costs
Report_Total_RD_bus_costs(b)
Report_SM(it,b)
Report_Max_SM(b)
;
*****************************looping
loop(iitt,

rh(t)$(ord(t) le ord(iitt)*24 and ord(t) gt (ord(iitt)-1)*24) = yes
;


***************************** variable loop input 

$include 3_input_loop.gms
;

***************************** reactive variables bounds
* from MVAR to VAR
RD_Qg_pos.up(g,t) =0;
RD_Qg_neg.up(g,t) =0;

RD_Qg_pos.up(g,t)$(ord(g) = 2)  = 0.4*100000;
RD_Qg_neg.up(g,t)$(ord(g) = 2)  = 0.4*100000;

RD_Qg_pos.up(g,t)$(ord(g) = 5)  = 0.6*100000;
RD_Qg_neg.up(g,t)$(ord(g) = 5)  = 0.6*100000;

RD_Qpv_pos.up(p,t) = 0
;
RD_Qpv_neg.up(p,t) = 0
;


*****************************Solving redispatch

solve Redispatch minimizing RD_OF using LP;

report_violation(iitt,l,t) = violation.l(l,t)
;
Report_PG_up(iitt,g,t) = RD_Pg_up.l(g,t)
;
Report_PG_down(iitt,g,t)= RD_Pg_down.l(g,t)
;
Report_dem_resp_down(iitt,b,t) = RD_dem_resp_down.l(b,t)
;
Report_dem_resp_up(iitt,b,t) = RD_dem_resp_up.l(b,t)
;
Report_curtail(iitt,b,t) = RD_curtail.l(b,t)
;
Report_reactive_compensation(iitt,g,t) = RD_Qg_pos.l(g,t) + RD_Qg_neg.l(g,t)
;


Report_RD_costs(iitt) =             + sum((g,t)$rh(t), RD_Pg_up.l(g,t)  * GenD(g,'var')/1000000)
                                    + sum((g,t)$rh(t), (RD_Pg_down.l(g,t) ) * (MP_DH(t) - GenD(g,'var'))/1000000)
                                    
                                    + sum((g,t)$rh(t), RD_Qg_pos.l(g,t) * MP_DH(t)/1000000)
                                    + sum((g,t)$rh(t), RD_Qg_neg.l(g,t) * MP_DH(t)/1000000)
                                    + sum((p,t)$rh(t), RD_Qpv_pos.l(p,t) * MP_DH(t)/1000000)
                                    + sum((p,t)$rh(t), RD_Qpv_neg.l(p,t) * MP_DH(t)/1000000)
                                    
                                    + sum((b,t)$rh(t), RD_curtail.l(b,t) * MP_DH(t)/1000000);


                    
execute_unload "check_loop.gdx"
;
rh(t) = no
;
)
;
Report_Total_Curtail = sum((it,b,t), Report_curtail(it,b,t))
;
Report_Total_Redispatch_up = sum((it,g,t), Report_PG_up(it,g,t))
;
Report_Total_Redispatch_down = sum((it,g,t), Report_PG_down(it,g,t))
;
Report_Total_Reactive_Compensation = sum((it,g,t), Report_reactive_compensation(it,g,t))
;           
Report_Total_RD_costs = sum(it,Report_RD_costs(it))
;

execute_unload "Outpur_Result.gdx"
;

