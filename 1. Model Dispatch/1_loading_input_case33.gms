
$offtext
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
load_p(t)
load_q(t)
CF(t)
profil(t)
BP(b)
BQ(b)
Load_bus_p(t,b)
Load_bus_q(t,b)
system_costs
MP_DH(t)
;
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


load_p(t) = load_up(t,'Active Demand (MW)') /1000
;
load_q(t) = load_up(t,'Reactive Demand (var)')  /1000
;
CF(t)     = load_up(t,'Capacity factor PV')
;
MP_DH(t)  = load_up(t,'Day_ahead_price')
;
Load_bus_p(t,b) =  Load_bus_p(t,b)/1000
;
Load_bus_q(t,b) =  Load_bus_q(t,b)/1000
;
