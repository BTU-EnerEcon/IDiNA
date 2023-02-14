

parameter Qd(b)  *MVAR
/
1  0
2  0.06
3  0.04
4  0.08
5  0.03
6  0.02
7  0.1
8  0.1
9  0.02
10 0.02
11 0.03
12 0.035
13 0.035
14 0.08
15 0.01
16 0.02
17 0.02
18 0.04
19 0.04
20 0.04
21 0.04
22 0.04
23 0.05
24 0.2
25 0.2
26 0.025
27 0.025
28 0.02
29 0.07
30 0.6
31 0.07
32 0.1
33 0.04
/;




$ontext
Table MP_DH(t,*)
    price            
1   25.02
2   18.29
3   16.04
4   14.60
5   14.95
6   14.50
7   10.76
8   12.01
9   12.39
10  14.04
11  14.68
12  16.08
13  16.08
14  16.05
15  16.04
16  16.10
17  23.93
18  26.90
19  26.36
20  23.98
21  16.09
22  14.08
23  12.44
24  0.04
25  -12.11
26  -19.63
27  -19.37
28  -31.41
29  -46.97
30  -13.48
31  0.08
32  10.06
33  14.25
34  14.56
35  14.64
36  15.08
37  15.41
38  14.52
39  14.70
40  14.66
41  16.09
42  25.10
43  25.06
44  19.08
45  14.26
46  12.22
47  10.40
48  -0.33
49  -0.08
50  -0.07
51  -5.03
52  0.01
53  -0.04
54  0.03
55  -8.67
56  4.46
57  9.90
58  14.29
59  16.73
60  22.31
61  23.03
62  22.40
63  27.07
64  29.33
65  33.85
66  45.96
67  49.82
68  47.62
69  35.98
70  27.26
71  27.70
72  14.27
73  9.32
74  0.02
75  -0.04
76  0.01
77  0.00
78  -0.01
79  -3.18
80  -0.05
81  0.05
82  9.62
83  11.54
84  14.68
85  14.31
86  11.18
87  12.01
88  14.36
89  17.55
90  28.94
91  29.59
92  29.42
93  28.92
94  28.66
95  29.74
96  24.90
;
$offtext
Table MP_DH(t,*)
    price            
1   25.02
2   18.29
3   16.04
4   14.60
5   14.95
6   14.50
7   10.76
8   12.01
9   12.39
10  14.04
11  14.68
12  16.08
13  16.08
14  16.05
15  16.04
16  16.10
17  23.93
18  26.90
19  26.36
20  23.98
21  16.09
22  14.08
23  12.44
24  10.23
25  14.25
26  14.56
27  15.41
28  12.22
29  16.09
30  26.90
31  14.25
32  10.06
33  14.25
34  14.56
35  14.64
36  15.08
37  15.41
38  14.52
39  14.70
40  14.66
41  16.09
42  25.10
43  25.06
44  19.08
45  14.26
46  12.22
47  10.40
48  9.32
49  16.73
50  16.73
51  16.73
52  16.73
53  16.73
54  16.73
55  16.73
56  4.46
57  9.90
58  14.29
59  16.73
60  22.31
61  23.03
62  22.40
63  27.07
64  29.33
65  33.85
66  45.96
67  49.82
68  47.62
69  35.98
70  27.26
71  27.70
72  14.27
73  9.32
74  11.54
75  11.54
76  11.54
77  11.54
78  11.54
79  11.54
80  11.54
81  11.54
82  9.62
83  11.54
84  14.68
85  14.31
86  11.18
87  12.01
88  14.36
89  17.55
90  28.94
91  29.59
92  29.42
93  28.92
94  28.66
95  29.74
96  24.90
;
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

profil(t)

BP(b)
BQ(b)
D_genP(g,t)
pv_infeed(b,t)

Load_bus_p(b,t)
load_bus_t(b,s,t)

Load_bus_q(b,t)
Load_deviation(b,s,t)

sl(l,t)
sLmax(l,t)
sLmax_scaled(l)
pl(l,t)
PF_result(s,l,t)
IN_PF_result_01(s,l,t)
IN_PF_result_02(s,l,t)
IN_PF_result_03(s,l,t)
IN_PF_result_04(s,l,t)
IN_PF_result_05(s,l,t)
IN_PF_result_06(s,l,t)
IN_PF_result_07(s,l,t)
IN_PF_result_08(s,l,t)
IN_PF_result_09(s,l,t)
IN_PF_result_10(s,l,t)

IN_PF_max_01(s,l,t)
IN_PF_max_02(s,l,t)
IN_PF_max_03(s,l,t)
IN_PF_max_04(s,l,t)
IN_PF_max_05(s,l,t)
IN_PF_max_06(s,l,t)
IN_PF_max_07(s,l,t)
IN_PF_max_08(s,l,t)
IN_PF_max_09(s,l,t)
IN_PF_max_10(s,l,t)


PTDF_PBPK(l,b,t)
PTDF_PBQK(l,b,t)
Line_Violation_test(s,l,t)

uki(b,t)
ukr(b,t)
ukn(b,t)
Vl(b,t)
PTDF_UKPK(b,bb,t)
PTDF_UKQK(b,bb,t)
VL_result(s,b,t)
IN_VL_result_01(s,b,t)
IN_VL_result_02(s,b,t)
IN_VL_result_03(s,b,t)
IN_VL_result_04(s,b,t)
IN_VL_result_05(s,b,t)
IN_VL_result_06(s,b,t)
IN_VL_result_07(s,b,t)
IN_VL_result_08(s,b,t)
IN_VL_result_09(s,b,t)
IN_VL_result_10(s,b,t)

IN_VL_max_01(s,b,t)
IN_VL_max_02(s,b,t)
IN_VL_max_03(s,b,t)
IN_VL_max_04(s,b,t)
IN_VL_max_05(s,b,t)
IN_VL_max_06(s,b,t)
IN_VL_max_07(s,b,t)
IN_VL_max_08(s,b,t)
IN_VL_max_09(s,b,t)
IN_VL_max_10(s,b,t)


Voltage_violation_up(s,b,t)
Voltage_violation_lo(s,b,t)

;
$onecho > PF.txt
par=IN_PF_result_01                   rng=Tabelle1!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_02                   rng=Tabelle2!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_03                   rng=Tabelle3!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_04                   rng=Tabelle4!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_05                   rng=Tabelle5!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_06                   rng=Tabelle6!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_07                   rng=Tabelle7!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_08                   rng=Tabelle8!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_09                   rng=Tabelle9!A1:CT31001                      rDim=2 cdim=1
par=IN_PF_result_10                   rng=Tabelle10!A1:CT31001                     rDim=2 cdim=1                  
$offecho
$onUNDF
$call   gdxxrw I=%winter%PF_Data_w_lpv_01.xlsx O=%winter%PF_Data_w_lpv_01.gdx @PF.txt
$GDXin  %winter%PF_Data_w_lpv_01.gdx
$load   IN_PF_result_01, IN_PF_result_02,  IN_PF_result_03,  IN_PF_result_04,  IN_PF_result_05
$load   IN_PF_result_06, IN_PF_result_07,  IN_PF_result_08,  IN_PF_result_09,  IN_PF_result_10
$GDXin
$offUNDF
;
$onecho > VL.txt
par=IN_VL_result_01                        rng=Tabelle1!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_02                        rng=Tabelle2!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_03                        rng=Tabelle3!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_04                        rng=Tabelle4!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_05                        rng=Tabelle5!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_06                        rng=Tabelle6!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_07                        rng=Tabelle7!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_08                        rng=Tabelle8!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_09                        rng=Tabelle9!A1:CT33001                       rDim=2 cdim=1
par=IN_VL_result_10                        rng=Tabelle10!A1:CT33001                      rDim=2 cdim=1              
$offecho
$onUNDF
$call   gdxxrw I=%winter%VL_Data_w_lpv_01.xlsx O=%winter%VL_Data_w_lpv_01.gdx @VL.txt
$GDXin  %winter%VL_Data_w_lpv_01.gdx
$load   IN_VL_result_01, IN_VL_result_02, IN_VL_result_03, IN_VL_result_04, IN_VL_result_05
$load   IN_VL_result_06, IN_VL_result_07, IN_VL_result_08, IN_VL_result_09, IN_VL_result_10 
$GDXin
$offUndf
;



$GDXin   IEEE_spring_hpv.gdx
$load    D_genP, pv_infeed, CF, load_bus_p

*$GDXin   IEEE_summer_hpv.gdx
*$load    D_genP, pv_infeed, CF, load_up, load_up_b

*$GDXin   IEEE_fall_hpv.gdx
*$load    D_genP, pv_infeed, CF, load_up, load_up_b

*$GDXin   IEEE_winter_hpv.gdx
*$load    D_genP, pv_infeed, CF, load_up, load_up_b


$GDXin   AC_IEEE_spring_hpv.gdx
$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK

*$GDXin   AC_IEEE_spring_hpv.gdx
*$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK

*$GDXin   AC_IEEE_spring_hpv.gdx
*$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK

*$GDXin   AC_IEEE_spring_hpv.gdx
*$load    pl,slmax, uki, ukr, ukn, PTDF_PBPK, PTDF_PBQK, PTDF_UKPK, PTDF_UKQK



*Load_bus(b) = load_up_b(b,'Active Demand')
*;


