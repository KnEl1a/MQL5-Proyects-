<chart>
id=133475603037346127
symbol=EURUSD
description=Euro vs US Dollar
period_type=0
period_size=1
digits=5
tick_size=0.000000
position_time=1701843900
scale_fix=0
scale_fixed_min=1.087700
scale_fixed_max=1.092000
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=2
mode=0
fore=0
grid=1
volume=1
scroll=0
shift=0
shift_size=19.691120
fixed_pos=0.000000
ticker=1
ohlc=0
one_click=0
one_click_btn=1
bidline=1
askline=0
lastline=0
days=0
descriptions=0
tradelines=1
tradehistory=1
window_left=52
window_top=52
window_right=1276
window_bottom=357
window_type=3
floating=0
floating_left=0
floating_top=0
floating_right=0
floating_bottom=0
floating_type=1
floating_toolbar=1
floating_tbstate=
background_color=0
foreground_color=16777215
barup_color=65280
bardown_color=65280
bullcandle_color=0
bearcandle_color=16777215
chartline_color=65280
volumes_color=3329330
grid_color=10061943
bidline_color=10061943
askline_color=255
lastline_color=49152
stops_color=255
windows_total=1

<expert>
name=Lot by Risk MT5
path=Experts\Market\Lot by Risk MT5.ex5
expertmode=1
<inputs>
MAGIC=111087
COMMENT=
FONT=7
CORNER=0
X_OFFSET=20
Y_OFFSET=20
HK_TP=T
HK_SL=S
HK_PR=P
L_TP=32768
L_SL=255
L_PR=42495
SLIPPAGE=5
RISK=1.0
COMISSION=0.0
</inputs>
</expert>

<window>
height=100.000000
objects=282

<indicator>
name=Main
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=4348.207550
scale_fix_min=0
scale_fix_min_val=4122.999325
scale_fix_max=0
scale_fix_max_val=4573.415775
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=1
width=1
arrow=251
color=13688896
</graph>
period=10
method=0
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=4348.207550
scale_fix_min=0
scale_fix_min_val=4122.999325
scale_fix_max=0
scale_fix_max_val=4573.415775
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=1
arrow=251
color=8388736
</graph>
period=30
method=0
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=4348.207550
scale_fix_min=0
scale_fix_min_val=4122.999325
scale_fix_max=0
scale_fix_max_val=4573.415775
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=1
arrow=251
color=3329434
</graph>
period=100
method=0
</indicator>

<indicator>
name=Moving Average
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=4348.207550
scale_fix_min=0
scale_fix_min_val=4122.999325
scale_fix_max=0
scale_fix_max_val=4573.415775
expertmode=0
fixed_height=-1

<graph>
name=
draw=129
style=0
width=1
arrow=251
color=128
</graph>
period=200
method=0
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\Market\Cybertrade ATR Trend Zone.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=IATR Value b[0]
draw=0
style=0
width=1
arrow=251
color=
</graph>

<graph>
name=IATR Direction b[1]
draw=0
style=0
width=1
arrow=251
color=
</graph>

<graph>
name=IATR Trend b[2]
draw=10
style=0
width=1
arrow=251
color=11186720,9639167,16777215
</graph>
<inputs>
InpTimeFrame=0
InpAtrPeriod=14
InpAtrMultp=3.0
</inputs>
</indicator>
<object>
type=2
name=H1 Trendline 35771
style=3
ray1=0
ray2=0
date1=1693296000
date2=1693350000
value1=15088.700000
value2=15014.578670
</object>

<object>
type=2
name=H1 Trendline 59236
style=3
ray1=0
ray2=0
date1=1650308400
date2=1650639600
value1=13765.672477
value2=14147.938532
</object>

<object>
type=2
name=H1 Trendline 628
style=3
ray1=0
ray2=0
date1=1639756800
date2=1640656800
value1=15909.293578
value2=15665.993119
</object>

<object>
type=2
name=Daily Trendline 24251
style=3
ray1=0
ray2=0
date1=1647820800
date2=1683849600
value1=15399.054587
value2=10854.558716
</object>

<object>
type=101
name=LBR_s_lineLabel
hidden=1
descr=stop loss
color=0
selectable=0
angle=0
date1=0
value1=15999.700000
fontsz=10
fontnm=Arial
anchorpos=0
</object>

<object>
type=2
name=Daily Trendline 32236
style=3
ray1=0
ray2=0
date1=1689793200
date2=1704844800
value1=15931.700000
value2=14741.162385
</object>

<object>
type=102
name=23412label_cmnt
hidden=1
descr=Comment:
color=2631995
selectable=0
angle=0
pos_x=28
pos_y=46
fontsz=7
fontnm=Trebuchet MS
anchorpos=0
refpoint=0
</object>

<object>
type=102
name=23412label_risk
hidden=1
descr=Risk:
color=2631995
selectable=0
angle=0
pos_x=28
pos_y=64
fontsz=7
fontnm=Trebuchet MS
anchorpos=0
refpoint=0
</object>

<object>
type=2
name=M1 Trendline 47222
style=3
ray1=0
ray2=0
date1=1702935240
date2=1702942560
value1=1.091340
value2=1.091630
</object>

<object>
type=2
name=M1 Trendline 29451
style=3
ray1=0
ray2=0
date1=1702522680
date2=1702527240
value1=1.089420
value2=1.088791
</object>

<object>
type=2
name=M1 Trendline 5216
style=3
ray1=0
ray2=0
date1=1702377360
date2=1702384380
value1=1.079199
value2=1.078551
</object>

<object>
type=31
name=autotrade #317188686 buy 0.01 EURUSD at 1.12010, EURUSD
hidden=1
color=11296515
selectable=0
date1=1689817300
value1=1.120100
</object>

<object>
type=32
name=autotrade #317188780 sell 0.01 EURUSD at 1.12012, profit 0.02, 
hidden=1
color=1918177
selectable=0
date1=1689817328
value1=1.120120
</object>

<object>
type=31
name=autotrade #317794185 buy 0.01 EURUSD at 1.11355, EURUSD
hidden=1
color=11296515
selectable=0
date1=1689902312
value1=1.113550
</object>

<object>
type=31
name=autotrade #317794198 buy 0.01 EURUSD at 1.11354, EURUSD
hidden=1
color=11296515
selectable=0
date1=1689902327
value1=1.113540
</object>

<object>
type=31
name=autotrade #317794208 buy 0.01 EURUSD at 1.11350, EURUSD
hidden=1
color=11296515
selectable=0
date1=1689902340
value1=1.113500
</object>

<object>
type=32
name=autotrade #318376313 sell 0.01 EURUSD at 1.11264, profit -0.86,
hidden=1
color=1918177
selectable=0
date1=1690161184
value1=1.112640
</object>

<object>
type=32
name=autotrade #318376314 sell 0.01 EURUSD at 1.11264, profit -0.91,
hidden=1
color=1918177
selectable=0
date1=1690161185
value1=1.112640
</object>

<object>
type=32
name=autotrade #318376338 sell 0.01 EURUSD at 1.11261, profit -0.93,
hidden=1
color=1918177
selectable=0
date1=1690161186
value1=1.112610
</object>

<object>
type=32
name=autotrade #320391792 sell 0.01 EURUSD at 1.11111, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690435078
value1=1.111110
</object>

<object>
type=31
name=autotrade #320391966 buy 0.01 EURUSD at 1.11117, profit -0.06, 
hidden=1
color=11296515
selectable=0
date1=1690435110
value1=1.111170
</object>

<object>
type=31
name=autotrade #320391974 buy 0.01 EURUSD at 1.11119, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690435113
value1=1.111190
</object>

<object>
type=32
name=autotrade #320392093 sell 0.01 EURUSD at 1.11121, profit 0.02, 
hidden=1
color=1918177
selectable=0
date1=1690435146
value1=1.111210
</object>

<object>
type=31
name=autotrade #320392163 buy 0.01 EURUSD at 1.11128, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690435169
value1=1.111280
</object>

<object>
type=32
name=autotrade #320392183 sell 0.01 EURUSD at 1.11127, profit -0.01,
hidden=1
color=1918177
selectable=0
date1=1690435181
value1=1.111270
</object>

<object>
type=32
name=autotrade #320392469 sell 0.01 EURUSD at 1.11125, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690435227
value1=1.111250
</object>

<object>
type=31
name=autotrade #320392479 buy 0.01 EURUSD at 1.11131, profit -0.06, 
hidden=1
color=11296515
selectable=0
date1=1690435229
value1=1.111310
</object>

<object>
type=32
name=autotrade #320392725 sell 0.01 EURUSD at 1.11104, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690435277
value1=1.111040
</object>

<object>
type=31
name=autotrade #320392741 buy 0.01 EURUSD at 1.11107, profit -0.03, 
hidden=1
color=11296515
selectable=0
date1=1690435280
value1=1.111070
</object>

<object>
type=32
name=autotrade #320392771 sell 0.01 EURUSD at 1.11105, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690435285
value1=1.111050
</object>

<object>
type=31
name=autotrade #320392845 buy 0.01 EURUSD at 1.11106, profit -0.01, 
hidden=1
color=11296515
selectable=0
date1=1690435301
value1=1.111060
</object>

<object>
type=32
name=autotrade #320392861 sell 0.01 EURUSD at 1.11106, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690435305
value1=1.111060
</object>

<object>
type=31
name=autotrade #320392875 buy 0.01 EURUSD at 1.11106, profit 0.00, E
hidden=1
color=11296515
selectable=0
date1=1690435307
value1=1.111060
</object>

<object>
type=32
name=autotrade #320392879 sell 0.01 EURUSD at 1.11106, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690435309
value1=1.111060
</object>

<object>
type=31
name=autotrade #320392902 buy 0.01 EURUSD at 1.11102, profit 0.04, E
hidden=1
color=11296515
selectable=0
date1=1690435315
value1=1.111020
</object>

<object>
type=31
name=autotrade #320392972 buy 0.01 EURUSD at 1.11100, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690435330
value1=1.111000
</object>

<object>
type=32
name=autotrade #320393253 sell 0.01 EURUSD at 1.11100, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1690435398
value1=1.111000
</object>

<object>
type=32
name=autotrade #321005531 sell 0.01 EURUSD at 1.09761, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690494178
value1=1.097610
</object>

<object>
type=31
name=autotrade #321007898 buy 0.01 EURUSD at 1.09807, profit -0.46, 
hidden=1
color=11296515
selectable=0
date1=1690494509
value1=1.098070
</object>

<object>
type=31
name=autotrade #322550249 buy 1 EURUSD at 1.09841, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690874909
value1=1.098410
</object>

<object>
type=32
name=autotrade #322550252 sell 1 EURUSD at 1.09841, profit 0.00, EUR
hidden=1
color=1918177
selectable=0
date1=1690874912
value1=1.098410
</object>

<object>
type=31
name=autotrade #322550270 buy 1 EURUSD at 1.09846, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690874921
value1=1.098460
</object>

<object>
type=32
name=autotrade #322550276 sell 1 EURUSD at 1.09844, profit -2.00, EU
hidden=1
color=1918177
selectable=0
date1=1690874925
value1=1.098440
</object>

<object>
type=31
name=autotrade #322550385 buy 1 EURUSD at 1.09846, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690874951
value1=1.098460
</object>

<object>
type=32
name=autotrade #322550395 sell 1 EURUSD at 1.09846, profit 0.00, EUR
hidden=1
color=1918177
selectable=0
date1=1690874954
value1=1.098460
</object>

<object>
type=32
name=autotrade #322553833 sell 1 EURUSD at 1.09830, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690875025
value1=1.098300
</object>

<object>
type=31
name=autotrade #322553933 buy 1 EURUSD at 1.09829, profit 1.00, EURU
hidden=1
color=11296515
selectable=0
date1=1690875031
value1=1.098290
</object>

<object>
type=32
name=autotrade #322554093 sell 1 EURUSD at 1.09829, EURUSD
hidden=1
color=1918177
selectable=0
date1=1690875041
value1=1.098290
</object>

<object>
type=31
name=autotrade #322554134 buy 1 EURUSD at 1.09834, profit -5.00, EUR
hidden=1
color=11296515
selectable=0
date1=1690875044
value1=1.098340
</object>

<object>
type=31
name=autotrade #322556028 buy 1 EURUSD at 1.09871, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690875274
value1=1.098710
</object>

<object>
type=32
name=autotrade #322556046 sell 1 EURUSD at 1.09868, profit -3.00, EU
hidden=1
color=1918177
selectable=0
date1=1690875282
value1=1.098680
</object>

<object>
type=31
name=autotrade #322556282 buy 0.01 EURUSD at 1.09868, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690875313
value1=1.098680
</object>

<object>
type=32
name=autotrade #322556335 sell 0.01 EURUSD at 1.09874, profit 0.06, 
hidden=1
color=1918177
selectable=0
date1=1690875321
value1=1.098740
</object>

<object>
type=31
name=autotrade #322558629 buy 0.01 EURUSD at 1.09859, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690875646
value1=1.098590
</object>

<object>
type=32
name=autotrade #322558768 sell 0.01 EURUSD at 1.09855, profit -0.04,
hidden=1
color=1918177
selectable=0
date1=1690875654
value1=1.098550
</object>

<object>
type=31
name=autotrade #322558890 buy 0.01 EURUSD at 1.09852, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690875667
value1=1.098520
</object>

<object>
type=32
name=autotrade #322558920 sell 0.01 EURUSD at 1.09849, profit -0.03,
hidden=1
color=1918177
selectable=0
date1=1690875673
value1=1.098490
</object>

<object>
type=31
name=autotrade #322559274 buy 0.01 EURUSD at 1.09860, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690875736
value1=1.098600
</object>

<object>
type=32
name=autotrade #322559360 sell 0.01 EURUSD at 1.09860, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1690875741
value1=1.098600
</object>

<object>
type=31
name=autotrade #322564351 buy 0.01 EURUSD at 1.09889, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690876482
value1=1.098890
</object>

<object>
type=32
name=autotrade #322564372 sell 0.01 EURUSD at 1.09888, profit -0.01,
hidden=1
color=1918177
selectable=0
date1=1690876490
value1=1.098880
</object>

<object>
type=31
name=autotrade #322564454 buy 0.01 EURUSD at 1.09887, EURUSD
hidden=1
color=11296515
selectable=0
date1=1690876505
value1=1.098870
</object>

<object>
type=32
name=autotrade #322564461 sell 0.01 EURUSD at 1.09887, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1690876508
value1=1.098870
</object>

<object>
type=31
name=autotrade #348675332 buy 0.01 EURUSD at 1.07329, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694658599
value1=1.073290
</object>

<object>
type=31
name=autotrade #348675333 buy 0.28 EURUSD at 1.07329, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694658599
value1=1.073290
</object>

<object>
type=32
name=autotrade #348675623 sell 0.28 EURUSD at 1.07332, profit 0.84, 
hidden=1
color=1918177
selectable=0
date1=1694658610
value1=1.073320
</object>

<object>
type=32
name=autotrade #348675624 sell 0.01 EURUSD at 1.07332, profit 0.03, 
hidden=1
color=1918177
selectable=0
date1=1694658611
value1=1.073320
</object>

<object>
type=31
name=autotrade #348677982 buy 0.01 EURUSD at 1.07336, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694659445
value1=1.073360
</object>

<object>
type=31
name=autotrade #348677983 buy 0.2 EURUSD at 1.07336, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694659445
value1=1.073360
</object>

<object>
type=32
name=autotrade #348678012 sell 0.01 EURUSD at 1.07335, profit -0.01,
hidden=1
color=1918177
selectable=0
date1=1694659459
value1=1.073350
</object>

<object>
type=32
name=autotrade #348680315 sell 0.2 EURUSD at 1.07339, profit 0.60, E
hidden=1
color=1918177
selectable=0
date1=1694660076
value1=1.073390
</object>

<object>
type=31
name=autotrade #348680334 buy 0.01 EURUSD at 1.07340, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660083
value1=1.073400
</object>

<object>
type=31
name=autotrade #348680335 buy 0.18 EURUSD at 1.07340, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660083
value1=1.073400
</object>

<object>
type=32
name=autotrade #348680365 sell 0.01 EURUSD at 1.07339, profit -0.01,
hidden=1
color=1918177
selectable=0
date1=1694660090
value1=1.073390
</object>

<object>
type=32
name=autotrade #348680937 sell 0.18 EURUSD at 1.07335, profit -0.90,
hidden=1
color=1918177
selectable=0
date1=1694660251
value1=1.073350
</object>

<object>
type=31
name=autotrade #348682388 buy 0.31 EURUSD at 1.07329, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660433
value1=1.073290
</object>

<object>
type=32
name=autotrade #348682678 sell 0.31 EURUSD at 1.07314, profit -4.65,
hidden=1
color=1918177
selectable=0
date1=1694660450
value1=1.073140
</object>

<object>
type=31
name=autotrade #348682753 buy 0.21 EURUSD at 1.07315, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660456
value1=1.073150
</object>

<object>
type=32
name=autotrade #348682949 sell 0.21 EURUSD at 1.07318, profit 0.63, 
hidden=1
color=1918177
selectable=0
date1=1694660476
value1=1.073180
</object>

<object>
type=31
name=autotrade #348682983 buy 0.2 EURUSD at 1.07319, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660482
value1=1.073190
</object>

<object>
type=32
name=autotrade #348683066 sell 0.2 EURUSD at 1.07328, profit 1.80, E
hidden=1
color=1918177
selectable=0
date1=1694660492
value1=1.073280
</object>

<object>
type=31
name=autotrade #348683099 buy 0.16 EURUSD at 1.07328, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660494
value1=1.073280
</object>

<object>
type=32
name=autotrade #348683805 sell 0.16 EURUSD at 1.07308, profit -3.20,
hidden=1
color=1918177
selectable=0
date1=1694660589
value1=1.073080
</object>

<object>
type=31
name=autotrade #348683841 buy 0.25 EURUSD at 1.07308, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660594
value1=1.073080
</object>

<object>
type=32
name=autotrade #348683944 sell 0.25 EURUSD at 1.07314, profit 1.50, 
hidden=1
color=1918177
selectable=0
date1=1694660608
value1=1.073140
</object>

<object>
type=31
name=autotrade #348684029 buy 0.22 EURUSD at 1.07319, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660610
value1=1.073190
</object>

<object>
type=32
name=autotrade #348684149 sell 0.22 EURUSD at 1.07318, profit -0.22,
hidden=1
color=1918177
selectable=0
date1=1694660631
value1=1.073180
</object>

<object>
type=31
name=autotrade #348684154 buy 0.2 EURUSD at 1.07318, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660632
value1=1.073180
</object>

<object>
type=32
name=autotrade #348684195 sell 0.2 EURUSD at 1.07320, profit 0.40, E
hidden=1
color=1918177
selectable=0
date1=1694660638
value1=1.073200
</object>

<object>
type=31
name=autotrade #348684232 buy 0.2 EURUSD at 1.07319, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660639
value1=1.073190
</object>

<object>
type=32
name=autotrade #348684312 sell 0.2 EURUSD at 1.07319, profit 0.00, E
hidden=1
color=1918177
selectable=0
date1=1694660645
value1=1.073190
</object>

<object>
type=31
name=autotrade #348684334 buy 0.2 EURUSD at 1.07320, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660649
value1=1.073200
</object>

<object>
type=32
name=autotrade #348684370 sell 0.2 EURUSD at 1.07320, profit 0.00, E
hidden=1
color=1918177
selectable=0
date1=1694660656
value1=1.073200
</object>

<object>
type=31
name=autotrade #348684453 buy 0.04 EURUSD at 1.07324, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660662
value1=1.073240
</object>

<object>
type=32
name=autotrade #348684569 sell 0.04 EURUSD at 1.07319, profit -0.20,
hidden=1
color=1918177
selectable=0
date1=1694660678
value1=1.073190
</object>

<object>
type=31
name=autotrade #348685023 buy 0.51 EURUSD at 1.07319, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660721
value1=1.073190
</object>

<object>
type=32
name=autotrade #348685042 sell 0.51 EURUSD at 1.07319, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1694660728
value1=1.073190
</object>

<object>
type=31
name=autotrade #348685061 buy 0.04 EURUSD at 1.07320, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660732
value1=1.073200
</object>

<object>
type=32
name=autotrade #348685148 sell 0.04 EURUSD at 1.07320, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1694660747
value1=1.073200
</object>

<object>
type=31
name=autotrade #348685421 buy 0.04 EURUSD at 1.07314, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660797
value1=1.073140
</object>

<object>
type=32
name=autotrade #348685739 sell 0.04 EURUSD at 1.07318, profit 0.16, 
hidden=1
color=1918177
selectable=0
date1=1694660834
value1=1.073180
</object>

<object>
type=31
name=autotrade #348685762 buy 0.04 EURUSD at 1.07318, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660837
value1=1.073180
</object>

<object>
type=32
name=autotrade #348685784 sell 0.04 EURUSD at 1.07318, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1694660842
value1=1.073180
</object>

<object>
type=31
name=autotrade #348685936 buy 0.04 EURUSD at 1.07319, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660872
value1=1.073190
</object>

<object>
type=32
name=autotrade #348686060 sell 0.04 EURUSD at 1.07320, profit 0.04, 
hidden=1
color=1918177
selectable=0
date1=1694660880
value1=1.073200
</object>

<object>
type=31
name=autotrade #348686084 buy 0.04 EURUSD at 1.07319, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660881
value1=1.073190
</object>

<object>
type=32
name=autotrade #348686209 sell 0.04 EURUSD at 1.07320, profit 0.04, 
hidden=1
color=1918177
selectable=0
date1=1694660888
value1=1.073200
</object>

<object>
type=31
name=autotrade #348686216 buy 0.04 EURUSD at 1.07320, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660889
value1=1.073200
</object>

<object>
type=32
name=autotrade #348686302 sell 0.04 EURUSD at 1.07320, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1694660895
value1=1.073200
</object>

<object>
type=31
name=autotrade #348686355 buy 0.07 EURUSD at 1.07320, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660908
value1=1.073200
</object>

<object>
type=32
name=autotrade #348686664 sell 0.07 EURUSD at 1.07320, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1694660950
value1=1.073200
</object>

<object>
type=31
name=autotrade #348686731 buy 0.18 EURUSD at 1.07322, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694660964
value1=1.073220
</object>

<object>
type=32
name=autotrade #348687119 sell 0.18 EURUSD at 1.07320, profit -0.36,
hidden=1
color=1918177
selectable=0
date1=1694661021
value1=1.073200
</object>

<object>
type=31
name=autotrade #348689634 buy 0.18 EURUSD at 1.07318, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694661390
value1=1.073180
</object>

<object>
type=31
name=autotrade #348689864 buy 0.04 EURUSD at 1.07323, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694661404
value1=1.073230
</object>

<object>
type=32
name=autotrade #348689884 sell 0.18 EURUSD at 1.07322, profit 0.72, 
hidden=1
color=1918177
selectable=0
date1=1694661406
value1=1.073220
</object>

<object>
type=32
name=autotrade #348689962 sell 0.04 EURUSD at 1.07322, profit -0.04,
hidden=1
color=1918177
selectable=0
date1=1694661416
value1=1.073220
</object>

<object>
type=31
name=autotrade #348690938 buy 0.03 EURUSD at 1.07339, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694661483
value1=1.073390
</object>

<object>
type=32
name=autotrade #348691074 sell 0.03 EURUSD at 1.07333, profit -0.18,
hidden=1
color=1918177
selectable=0
date1=1694661494
value1=1.073330
</object>

<object>
type=32
name=autotrade #348691085 sell 0.02 EURUSD at 1.07333, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694661497
value1=1.073330
</object>

<object>
type=31
name=autotrade #348691283 buy 0.02 EURUSD at 1.07330, profit 0.06, E
hidden=1
color=11296515
selectable=0
date1=1694661511
value1=1.073300
</object>

<object>
type=32
name=autotrade #348691572 sell 0.02 EURUSD at 1.07324, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694661560
value1=1.073240
</object>

<object>
type=31
name=autotrade #348691621 buy 0.02 EURUSD at 1.07320, profit 0.08, E
hidden=1
color=11296515
selectable=0
date1=1694661569
value1=1.073200
</object>

<object>
type=31
name=autotrade #348701895 buy 0.03 EURUSD at 1.07350, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694662720
value1=1.073500
</object>

<object>
type=32
name=autotrade #348701904 sell 0.03 EURUSD at 1.07347, profit -0.09,
hidden=1
color=1918177
selectable=0
date1=1694662724
value1=1.073470
</object>

<object>
type=32
name=autotrade #348701928 sell 0.02 EURUSD at 1.07347, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694662725
value1=1.073470
</object>

<object>
type=31
name=autotrade #348702406 buy 0.02 EURUSD at 1.07354, profit -0.14, 
hidden=1
color=11296515
selectable=0
date1=1694662786
value1=1.073540
</object>

<object>
type=31
name=autotrade #348702411 buy 0.03 EURUSD at 1.07352, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694662788
value1=1.073520
</object>

<object>
type=32
name=autotrade #348702622 sell 0.03 EURUSD at 1.07362, profit 0.30, 
hidden=1
color=1918177
selectable=0
date1=1694662791
value1=1.073620
</object>

<object>
type=32
name=autotrade #348702706 sell 0.03 EURUSD at 1.07360, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694662793
value1=1.073600
</object>

<object>
type=31
name=autotrade #348703288 buy 0.03 EURUSD at 1.07363, profit -0.09, 
hidden=1
color=11296515
selectable=0
date1=1694662813
value1=1.073630
</object>

<object>
type=31
name=autotrade #348703343 buy 0.03 EURUSD at 1.07362, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694662816
value1=1.073620
</object>

<object>
type=32
name=autotrade #348703372 sell 0.03 EURUSD at 1.07362, profit 0.00, 
hidden=1
color=1918177
selectable=0
date1=1694662821
value1=1.073620
</object>

<object>
type=32
name=autotrade #348703384 sell 0.03 EURUSD at 1.07362, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694662823
value1=1.073620
</object>

<object>
type=31
name=autotrade #348703413 buy 0.03 EURUSD at 1.07362, profit 0.00, E
hidden=1
color=11296515
selectable=0
date1=1694662829
value1=1.073620
</object>

<object>
type=32
name=autotrade #348703416 sell 0.03 EURUSD at 1.07361, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694662830
value1=1.073610
</object>

<object>
type=31
name=autotrade #348704677 buy 0.03 EURUSD at 1.07364, profit -0.09, 
hidden=1
color=11296515
selectable=0
date1=1694662913
value1=1.073640
</object>

<object>
type=31
name=autotrade #348704701 buy 0.03 EURUSD at 1.07364, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694662916
value1=1.073640
</object>

<object>
type=32
name=autotrade #348704714 sell 0.03 EURUSD at 1.07364, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694662918
value1=1.073640
</object>

<object>
type=32
name=autotrade #348704842 sell 0.03 EURUSD at 1.07366, profit 0.06, 
hidden=1
color=1918177
selectable=0
date1=1694662924
value1=1.073660
</object>

<object>
type=31
name=autotrade #348704860 buy 0.03 EURUSD at 1.07366, profit -0.06, 
hidden=1
color=11296515
selectable=0
date1=1694662925
value1=1.073660
</object>

<object>
type=32
name=autotrade #348707678 sell 0.03 EURUSD at 1.07378, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694663195
value1=1.073780
</object>

<object>
type=31
name=autotrade #348707726 buy 0.03 EURUSD at 1.07379, profit -0.03, 
hidden=1
color=11296515
selectable=0
date1=1694663203
value1=1.073790
</object>

<object>
type=31
name=autotrade #348730255 buy 0.07 EURUSD at 1.07392, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694665232
value1=1.073920
</object>

<object>
type=32
name=autotrade #348730265 sell 0.07 EURUSD at 1.07391, profit -0.07,
hidden=1
color=1918177
selectable=0
date1=1694665236
value1=1.073910
</object>

<object>
type=32
name=autotrade #348730267 sell 0.23 EURUSD at 1.07391, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694665238
value1=1.073910
</object>

<object>
type=31
name=autotrade #348730276 buy 0.23 EURUSD at 1.07390, profit 0.23, E
hidden=1
color=11296515
selectable=0
date1=1694665240
value1=1.073900
</object>

<object>
type=32
name=autotrade #349920361 sell 0.01 EURUSD at 1.06480, EURUSD
hidden=1
color=1918177
selectable=0
date1=1694792587
value1=1.064800
</object>

<object>
type=31
name=autotrade #349920428 buy 0.01 EURUSD at 1.06482, profit -0.02, 
hidden=1
color=11296515
selectable=0
date1=1694792600
value1=1.064820
</object>

<object>
type=31
name=autotrade #349920436 buy 0.05 EURUSD at 1.06482, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694792601
value1=1.064820
</object>

<object>
type=32
name=autotrade #349920579 sell 0.05 EURUSD at 1.06491, profit 0.45, 
hidden=1
color=1918177
selectable=0
date1=1694792611
value1=1.064910
</object>

<object>
type=31
name=autotrade #349920600 buy 0.04 EURUSD at 1.06492, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694792614
value1=1.064920
</object>

<object>
type=32
name=autotrade #349920801 sell 0.04 EURUSD at 1.06490, profit -0.08,
hidden=1
color=1918177
selectable=0
date1=1694792635
value1=1.064900
</object>

<object>
type=31
name=autotrade #349991834 buy 0.16 EURUSD at 1.06622, EURUSD
hidden=1
color=11296515
selectable=0
date1=1694796883
value1=1.066220
</object>

<object>
type=32
name=autotrade #349993014 sell 0.16 EURUSD at 1.06631, profit 1.44, 
hidden=1
color=1918177
selectable=0
date1=1694796981
value1=1.066310
</object>

<object>
type=31
name=autotrade #395945962 buy 0.1 EURUSD at 1.07841, EURUSD
hidden=1
color=11296515
selectable=0
date1=1702040702
value1=1.078410
</object>

<object>
type=32
name=autotrade #395946060 sell 0.1 EURUSD at 1.07830, profit -1.10, 
hidden=1
color=1918177
selectable=0
date1=1702040713
value1=1.078300
</object>

<object>
type=31
name=autotrade #395961981 buy 0.1 EURUSD at 1.07813, EURUSD
hidden=1
color=11296515
selectable=0
date1=1702042316
value1=1.078130
</object>

<object>
type=32
name=autotrade #395962001 sell 0.1 EURUSD at 1.07812, profit -0.10, 
hidden=1
color=1918177
selectable=0
date1=1702042319
value1=1.078120
</object>

<object>
type=31
name=autotrade #396261046 buy 0.01 EURUSD at 1.07803, EURUSD
hidden=1
color=11296515
selectable=0
date1=1702055812
value1=1.078030
</object>

<object>
type=32
name=autotrade #396660330 sell 0.01 EURUSD at 1.07686, profit -1.17,
hidden=1
color=1918177
selectable=0
date1=1702263303
value1=1.076860
</object>

<object>
type=31
name=autotrade #397300838 buy 0.03 EURUSD at 1.07667, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702328691
value1=1.076670
</object>

<object>
type=31
name=autotrade #397315966 buy 0.03 EURUSD at 1.07659, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702330444
value1=1.076590
</object>

<object>
type=32
name=autotrade #397317156 sell 0.03 EURUSD at 1.07632, SL, profit -1
hidden=1
descr=[sl 1.07632]
color=1918177
selectable=0
date1=1702330630
value1=1.076320
</object>

<object>
type=32
name=autotrade #397317157 sell 0.03 EURUSD at 1.07632, SL, profit -0
hidden=1
descr=[sl 1.07633]
color=1918177
selectable=0
date1=1702330630
value1=1.076320
</object>

<object>
type=31
name=autotrade #398038595 buy 0.2 EURUSD at 1.07892, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702410910
value1=1.078920
</object>

<object>
type=32
name=autotrade #398045638 sell 0.2 EURUSD at 1.07947, profit 11.00, 
hidden=1
color=1918177
selectable=0
date1=1702411385
value1=1.079470
</object>

<object>
type=31
name=autotrade #399855160 buy 0.01 EURUSD at 1.09962, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702578236
value1=1.099620
</object>

<object>
type=32
name=autotrade #399856285 sell 0.01 EURUSD at 1.09946, profit -0.16,
hidden=1
color=1918177
selectable=0
date1=1702578362
value1=1.099460
</object>

<object>
type=31
name=autotrade #399856629 buy 0.01 EURUSD at 1.09950, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702578395
value1=1.099500
</object>

<object>
type=32
name=autotrade #399880259 sell 0.01 EURUSD at 1.09928, SL, profit -0
hidden=1
descr=[sl 1.09928]
color=1918177
selectable=0
date1=1702580586
value1=1.099280
</object>

<object>
type=31
name=autotrade #399983535 buy 0.07 EURUSD at 1.09888, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702588791
value1=1.098880
</object>

<object>
type=32
name=autotrade #399989336 sell 0.07 EURUSD at 1.09932, profit 3.08, 
hidden=1
color=1918177
selectable=0
date1=1702589342
value1=1.099320
</object>

<object>
type=31
name=autotrade #400000962 buy 0.01 EURUSD at 1.09869, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702590827
value1=1.098690
</object>

<object>
type=32
name=autotrade #400013021 sell 0.01 EURUSD at 1.09930, EURUSD
hidden=1
descr= 
color=1918177
selectable=0
date1=1702592287
value1=1.099300
</object>

<object>
type=31
name=autotrade #400013040 buy 0.01 EURUSD at 1.09930, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702592290
value1=1.099300
</object>

<object>
type=31
name=autotrade #400013061 buy 0.01 EURUSD at 1.09930, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702592292
value1=1.099300
</object>

<object>
type=32
name=autotrade #400013987 sell 0.01 EURUSD at 1.09936, profit 0.06, 
hidden=1
color=1918177
selectable=0
date1=1702592401
value1=1.099360
</object>

<object>
type=32
name=autotrade #400014001 sell 0.01 EURUSD at 1.09938, profit 0.08, 
hidden=1
color=1918177
selectable=0
date1=1702592402
value1=1.099380
</object>

<object>
type=31
name=autotrade #400014019 buy 0.01 EURUSD at 1.09932, profit -0.02, 
hidden=1
color=11296515
selectable=0
date1=1702592403
value1=1.099320
</object>

<object>
type=32
name=autotrade #400014027 sell 0.01 EURUSD at 1.09932, profit 0.63, 
hidden=1
color=1918177
selectable=0
date1=1702592403
value1=1.099320
</object>

<object>
type=31
name=autotrade #401246722 buy 0.01 EURUSD at 1.09111, EURUSD
hidden=1
descr= 
color=11296515
selectable=0
date1=1702877307
value1=1.091110
</object>

<object>
type=32
name=autotrade #401246767 sell 0.01 EURUSD at 1.09112, profit 0.01, 
hidden=1
color=1918177
selectable=0
date1=1702877320
value1=1.091120
</object>

<object>
type=2
name=autotrade #317188686 -> #317188780, profit 0.02, EURUSD
hidden=1
descr=1.12010 -> 1.12012
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1689817300
date2=1689817328
value1=1.120100
value2=1.120120
</object>

<object>
type=2
name=autotrade #317794185 -> #318376314, profit -0.91, EURUSD
hidden=1
descr=1.11355 -> 1.11264
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1689902312
date2=1690161185
value1=1.113550
value2=1.112640
</object>

<object>
type=2
name=autotrade #317794198 -> #318376338, profit -0.93, EURUSD
hidden=1
descr=1.11354 -> 1.11261
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1689902327
date2=1690161186
value1=1.113540
value2=1.112610
</object>

<object>
type=2
name=autotrade #317794208 -> #318376313, profit -0.86, EURUSD
hidden=1
descr=1.11350 -> 1.11264
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1689902340
date2=1690161184
value1=1.113500
value2=1.112640
</object>

<object>
type=2
name=autotrade #320391792 -> #320391966, profit -0.06, EURUSD
hidden=1
descr=1.11111 -> 1.11117
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690435078
date2=1690435110
value1=1.111110
value2=1.111170
</object>

<object>
type=2
name=autotrade #320391974 -> #320392093, profit 0.02, EURUSD
hidden=1
descr=1.11119 -> 1.11121
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690435113
date2=1690435146
value1=1.111190
value2=1.111210
</object>

<object>
type=2
name=autotrade #320392163 -> #320392183, profit -0.01, EURUSD
hidden=1
descr=1.11128 -> 1.11127
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690435169
date2=1690435181
value1=1.111280
value2=1.111270
</object>

<object>
type=2
name=autotrade #320392469 -> #320392479, profit -0.06, EURUSD
hidden=1
descr=1.11125 -> 1.11131
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690435227
date2=1690435229
value1=1.111250
value2=1.111310
</object>

<object>
type=2
name=autotrade #320392725 -> #320392741, profit -0.03, EURUSD
hidden=1
descr=1.11104 -> 1.11107
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690435277
date2=1690435280
value1=1.111040
value2=1.111070
</object>

<object>
type=2
name=autotrade #320392771 -> #320392845, profit -0.01, EURUSD
hidden=1
descr=1.11105 -> 1.11106
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690435285
date2=1690435301
value1=1.111050
value2=1.111060
</object>

<object>
type=2
name=autotrade #320392861 -> #320392875, profit 0.00, EURUSD
hidden=1
descr=1.11106 -> 1.11106
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690435305
date2=1690435307
value1=1.111060
value2=1.111060
</object>

<object>
type=2
name=autotrade #320392879 -> #320392902, profit 0.04, EURUSD
hidden=1
descr=1.11106 -> 1.11102
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690435309
date2=1690435315
value1=1.111060
value2=1.111020
</object>

<object>
type=2
name=autotrade #320392972 -> #320393253, profit 0.00, EURUSD
hidden=1
descr=1.11100 -> 1.11100
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690435330
date2=1690435398
value1=1.111000
value2=1.111000
</object>

<object>
type=2
name=autotrade #321005531 -> #321007898, profit -0.46, EURUSD
hidden=1
descr=1.09761 -> 1.09807
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690494178
date2=1690494509
value1=1.097610
value2=1.098070
</object>

<object>
type=2
name=autotrade #322550249 -> #322550252, profit 0.00, EURUSD
hidden=1
descr=1.09841 -> 1.09841
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690874909
date2=1690874912
value1=1.098410
value2=1.098410
</object>

<object>
type=2
name=autotrade #322550270 -> #322550276, profit -2.00, EURUSD
hidden=1
descr=1.09846 -> 1.09844
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690874921
date2=1690874925
value1=1.098460
value2=1.098440
</object>

<object>
type=2
name=autotrade #322550385 -> #322550395, profit 0.00, EURUSD
hidden=1
descr=1.09846 -> 1.09846
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690874951
date2=1690874954
value1=1.098460
value2=1.098460
</object>

<object>
type=2
name=autotrade #322553833 -> #322553933, profit 1.00, EURUSD
hidden=1
descr=1.09830 -> 1.09829
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690875025
date2=1690875031
value1=1.098300
value2=1.098290
</object>

<object>
type=2
name=autotrade #322554093 -> #322554134, profit -5.00, EURUSD
hidden=1
descr=1.09829 -> 1.09834
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1690875041
date2=1690875044
value1=1.098290
value2=1.098340
</object>

<object>
type=2
name=autotrade #322556028 -> #322556046, profit -3.00, EURUSD
hidden=1
descr=1.09871 -> 1.09868
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690875274
date2=1690875282
value1=1.098710
value2=1.098680
</object>

<object>
type=2
name=autotrade #322556282 -> #322556335, profit 0.06, EURUSD
hidden=1
descr=1.09868 -> 1.09874
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690875313
date2=1690875321
value1=1.098680
value2=1.098740
</object>

<object>
type=2
name=autotrade #322558629 -> #322558768, profit -0.04, EURUSD
hidden=1
descr=1.09859 -> 1.09855
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690875646
date2=1690875654
value1=1.098590
value2=1.098550
</object>

<object>
type=2
name=autotrade #322558890 -> #322558920, profit -0.03, EURUSD
hidden=1
descr=1.09852 -> 1.09849
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690875667
date2=1690875673
value1=1.098520
value2=1.098490
</object>

<object>
type=2
name=autotrade #322559274 -> #322559360, profit 0.00, EURUSD
hidden=1
descr=1.09860 -> 1.09860
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690875736
date2=1690875741
value1=1.098600
value2=1.098600
</object>

<object>
type=2
name=autotrade #322564351 -> #322564372, profit -0.01, EURUSD
hidden=1
descr=1.09889 -> 1.09888
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690876482
date2=1690876490
value1=1.098890
value2=1.098880
</object>

<object>
type=2
name=autotrade #322564454 -> #322564461, profit 0.00, EURUSD
hidden=1
descr=1.09887 -> 1.09887
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1690876505
date2=1690876508
value1=1.098870
value2=1.098870
</object>

<object>
type=2
name=autotrade #348675332 -> #348675624, profit 0.03, EURUSD
hidden=1
descr=1.07329 -> 1.07332
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694658599
date2=1694658611
value1=1.073290
value2=1.073320
</object>

<object>
type=2
name=autotrade #348675333 -> #348675623, profit 0.84, EURUSD
hidden=1
descr=1.07329 -> 1.07332
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694658599
date2=1694658610
value1=1.073290
value2=1.073320
</object>

<object>
type=2
name=autotrade #348677982 -> #348678012, profit -0.01, EURUSD
hidden=1
descr=1.07336 -> 1.07335
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694659445
date2=1694659459
value1=1.073360
value2=1.073350
</object>

<object>
type=2
name=autotrade #348677983 -> #348680315, profit 0.60, EURUSD
hidden=1
descr=1.07336 -> 1.07339
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694659445
date2=1694660076
value1=1.073360
value2=1.073390
</object>

<object>
type=2
name=autotrade #348680334 -> #348680365, profit -0.01, EURUSD
hidden=1
descr=1.07340 -> 1.07339
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660083
date2=1694660090
value1=1.073400
value2=1.073390
</object>

<object>
type=2
name=autotrade #348680335 -> #348680937, profit -0.90, EURUSD
hidden=1
descr=1.07340 -> 1.07335
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660083
date2=1694660251
value1=1.073400
value2=1.073350
</object>

<object>
type=2
name=autotrade #348682388 -> #348682678, profit -4.65, EURUSD
hidden=1
descr=1.07329 -> 1.07314
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660433
date2=1694660450
value1=1.073290
value2=1.073140
</object>

<object>
type=2
name=autotrade #348682753 -> #348682949, profit 0.63, EURUSD
hidden=1
descr=1.07315 -> 1.07318
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660456
date2=1694660476
value1=1.073150
value2=1.073180
</object>

<object>
type=2
name=autotrade #348682983 -> #348683066, profit 1.80, EURUSD
hidden=1
descr=1.07319 -> 1.07328
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660482
date2=1694660492
value1=1.073190
value2=1.073280
</object>

<object>
type=2
name=autotrade #348683099 -> #348683805, profit -3.20, EURUSD
hidden=1
descr=1.07328 -> 1.07308
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660494
date2=1694660589
value1=1.073280
value2=1.073080
</object>

<object>
type=2
name=autotrade #348683841 -> #348683944, profit 1.50, EURUSD
hidden=1
descr=1.07308 -> 1.07314
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660594
date2=1694660608
value1=1.073080
value2=1.073140
</object>

<object>
type=2
name=autotrade #348684029 -> #348684149, profit -0.22, EURUSD
hidden=1
descr=1.07319 -> 1.07318
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660610
date2=1694660631
value1=1.073190
value2=1.073180
</object>

<object>
type=2
name=autotrade #348684154 -> #348684195, profit 0.40, EURUSD
hidden=1
descr=1.07318 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660632
date2=1694660638
value1=1.073180
value2=1.073200
</object>

<object>
type=2
name=autotrade #348684232 -> #348684312, profit 0.00, EURUSD
hidden=1
descr=1.07319 -> 1.07319
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660639
date2=1694660645
value1=1.073190
value2=1.073190
</object>

<object>
type=2
name=autotrade #348684334 -> #348684370, profit 0.00, EURUSD
hidden=1
descr=1.07320 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660649
date2=1694660656
value1=1.073200
value2=1.073200
</object>

<object>
type=2
name=autotrade #348684453 -> #348684569, profit -0.20, EURUSD
hidden=1
descr=1.07324 -> 1.07319
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660662
date2=1694660678
value1=1.073240
value2=1.073190
</object>

<object>
type=2
name=autotrade #348685023 -> #348685042, profit 0.00, EURUSD
hidden=1
descr=1.07319 -> 1.07319
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660721
date2=1694660728
value1=1.073190
value2=1.073190
</object>

<object>
type=2
name=autotrade #348685061 -> #348685148, profit 0.00, EURUSD
hidden=1
descr=1.07320 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660732
date2=1694660747
value1=1.073200
value2=1.073200
</object>

<object>
type=2
name=autotrade #348685421 -> #348685739, profit 0.16, EURUSD
hidden=1
descr=1.07314 -> 1.07318
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660797
date2=1694660834
value1=1.073140
value2=1.073180
</object>

<object>
type=2
name=autotrade #348685762 -> #348685784, profit 0.00, EURUSD
hidden=1
descr=1.07318 -> 1.07318
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660837
date2=1694660842
value1=1.073180
value2=1.073180
</object>

<object>
type=2
name=autotrade #348685936 -> #348686060, profit 0.04, EURUSD
hidden=1
descr=1.07319 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660872
date2=1694660880
value1=1.073190
value2=1.073200
</object>

<object>
type=2
name=autotrade #348686084 -> #348686209, profit 0.04, EURUSD
hidden=1
descr=1.07319 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660881
date2=1694660888
value1=1.073190
value2=1.073200
</object>

<object>
type=2
name=autotrade #348686216 -> #348686302, profit 0.00, EURUSD
hidden=1
descr=1.07320 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660889
date2=1694660895
value1=1.073200
value2=1.073200
</object>

<object>
type=2
name=autotrade #348686355 -> #348686664, profit 0.00, EURUSD
hidden=1
descr=1.07320 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660908
date2=1694660950
value1=1.073200
value2=1.073200
</object>

<object>
type=2
name=autotrade #348686731 -> #348687119, profit -0.36, EURUSD
hidden=1
descr=1.07322 -> 1.07320
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694660964
date2=1694661021
value1=1.073220
value2=1.073200
</object>

<object>
type=2
name=autotrade #348689634 -> #348689884, profit 0.72, EURUSD
hidden=1
descr=1.07318 -> 1.07322
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694661390
date2=1694661406
value1=1.073180
value2=1.073220
</object>

<object>
type=2
name=autotrade #348689864 -> #348689962, profit -0.04, EURUSD
hidden=1
descr=1.07323 -> 1.07322
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694661404
date2=1694661416
value1=1.073230
value2=1.073220
</object>

<object>
type=2
name=autotrade #348690938 -> #348691074, profit -0.18, EURUSD
hidden=1
descr=1.07339 -> 1.07333
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694661483
date2=1694661494
value1=1.073390
value2=1.073330
</object>

<object>
type=2
name=autotrade #348691085 -> #348691283, profit 0.06, EURUSD
hidden=1
descr=1.07333 -> 1.07330
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694661497
date2=1694661511
value1=1.073330
value2=1.073300
</object>

<object>
type=2
name=autotrade #348691572 -> #348691621, profit 0.08, EURUSD
hidden=1
descr=1.07324 -> 1.07320
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694661560
date2=1694661569
value1=1.073240
value2=1.073200
</object>

<object>
type=2
name=autotrade #348701895 -> #348701904, profit -0.09, EURUSD
hidden=1
descr=1.07350 -> 1.07347
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694662720
date2=1694662724
value1=1.073500
value2=1.073470
</object>

<object>
type=2
name=autotrade #348701928 -> #348702406, profit -0.14, EURUSD
hidden=1
descr=1.07347 -> 1.07354
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694662725
date2=1694662786
value1=1.073470
value2=1.073540
</object>

<object>
type=2
name=autotrade #348702411 -> #348702622, profit 0.30, EURUSD
hidden=1
descr=1.07352 -> 1.07362
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694662788
date2=1694662791
value1=1.073520
value2=1.073620
</object>

<object>
type=2
name=autotrade #348702706 -> #348703288, profit -0.09, EURUSD
hidden=1
descr=1.07360 -> 1.07363
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694662793
date2=1694662813
value1=1.073600
value2=1.073630
</object>

<object>
type=2
name=autotrade #348703343 -> #348703372, profit 0.00, EURUSD
hidden=1
descr=1.07362 -> 1.07362
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694662816
date2=1694662821
value1=1.073620
value2=1.073620
</object>

<object>
type=2
name=autotrade #348703384 -> #348703413, profit 0.00, EURUSD
hidden=1
descr=1.07362 -> 1.07362
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694662823
date2=1694662829
value1=1.073620
value2=1.073620
</object>

<object>
type=2
name=autotrade #348703416 -> #348704677, profit -0.09, EURUSD
hidden=1
descr=1.07361 -> 1.07364
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694662830
date2=1694662913
value1=1.073610
value2=1.073640
</object>

<object>
type=2
name=autotrade #348704701 -> #348704842, profit 0.06, EURUSD
hidden=1
descr=1.07364 -> 1.07366
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694662916
date2=1694662924
value1=1.073640
value2=1.073660
</object>

<object>
type=2
name=autotrade #348704714 -> #348704860, profit -0.06, EURUSD
hidden=1
descr=1.07364 -> 1.07366
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694662918
date2=1694662925
value1=1.073640
value2=1.073660
</object>

<object>
type=2
name=autotrade #348707678 -> #348707726, profit -0.03, EURUSD
hidden=1
descr=1.07378 -> 1.07379
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694663195
date2=1694663203
value1=1.073780
value2=1.073790
</object>

<object>
type=2
name=autotrade #348730255 -> #348730265, profit -0.07, EURUSD
hidden=1
descr=1.07392 -> 1.07391
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694665232
date2=1694665236
value1=1.073920
value2=1.073910
</object>

<object>
type=2
name=autotrade #348730267 -> #348730276, profit 0.23, EURUSD
hidden=1
descr=1.07391 -> 1.07390
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694665238
date2=1694665240
value1=1.073910
value2=1.073900
</object>

<object>
type=2
name=autotrade #349920361 -> #349920428, profit -0.02, EURUSD
hidden=1
descr=1.06480 -> 1.06482
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1694792587
date2=1694792600
value1=1.064800
value2=1.064820
</object>

<object>
type=2
name=autotrade #349920436 -> #349920579, profit 0.45, EURUSD
hidden=1
descr=1.06482 -> 1.06491
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694792601
date2=1694792611
value1=1.064820
value2=1.064910
</object>

<object>
type=2
name=autotrade #349920600 -> #349920801, profit -0.08, EURUSD
hidden=1
descr=1.06492 -> 1.06490
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694792614
date2=1694792635
value1=1.064920
value2=1.064900
</object>

<object>
type=2
name=autotrade #349991834 -> #349993014, profit 1.44, EURUSD
hidden=1
descr=1.06622 -> 1.06631
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1694796883
date2=1694796981
value1=1.066220
value2=1.066310
</object>

<object>
type=2
name=autotrade #395945962 -> #395946060, profit -1.10, EURUSD
hidden=1
descr=1.07841 -> 1.07830
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702040702
date2=1702040713
value1=1.078410
value2=1.078300
</object>

<object>
type=2
name=autotrade #395961981 -> #395962001, profit -0.10, EURUSD
hidden=1
descr=1.07813 -> 1.07812
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702042316
date2=1702042319
value1=1.078130
value2=1.078120
</object>

<object>
type=2
name=autotrade #396261046 -> #396660330, profit -1.17, EURUSD
hidden=1
descr=1.07803 -> 1.07686
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702055812
date2=1702263303
value1=1.078030
value2=1.076860
</object>

<object>
type=2
name=autotrade #397300838 -> #397317156, SL, profit -1.05, EURUSD
hidden=1
descr=1.07667 -> 1.07632
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702328691
date2=1702330630
value1=1.076670
value2=1.076320
</object>

<object>
type=2
name=autotrade #397315966 -> #397317157, SL, profit -0.81, EURUSD
hidden=1
descr=1.07659 -> 1.07632
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702330444
date2=1702330630
value1=1.076590
value2=1.076320
</object>

<object>
type=2
name=autotrade #398038595 -> #398045638, profit 11.00, EURUSD
hidden=1
descr=1.07892 -> 1.07947
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702410910
date2=1702411385
value1=1.078920
value2=1.079470
</object>

<object>
type=2
name=autotrade #399855160 -> #399856285, profit -0.16, EURUSD
hidden=1
descr=1.09962 -> 1.09946
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702578236
date2=1702578362
value1=1.099620
value2=1.099460
</object>

<object>
type=2
name=autotrade #399856629 -> #399880259, SL, profit -0.22, EURUSD
hidden=1
descr=1.09950 -> 1.09928
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702578395
date2=1702580586
value1=1.099500
value2=1.099280
</object>

<object>
type=2
name=autotrade #399983535 -> #399989336, profit 3.08, EURUSD
hidden=1
descr=1.09888 -> 1.09932
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702588791
date2=1702589342
value1=1.098880
value2=1.099320
</object>

<object>
type=2
name=autotrade #400000962 -> #400014027, profit 0.63, EURUSD
hidden=1
descr=1.09869 -> 1.09932
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702590827
date2=1702592403
value1=1.098690
value2=1.099320
</object>

<object>
type=2
name=autotrade #400013021 -> #400014019, profit -0.02, EURUSD
hidden=1
descr=1.09930 -> 1.09932
color=1918177
style=2
selectable=0
ray1=0
ray2=0
date1=1702592287
date2=1702592403
value1=1.099300
value2=1.099320
</object>

<object>
type=2
name=autotrade #400013040 -> #400014001, profit 0.08, EURUSD
hidden=1
descr=1.09930 -> 1.09938
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702592290
date2=1702592402
value1=1.099300
value2=1.099380
</object>

<object>
type=2
name=autotrade #400013061 -> #400013987, profit 0.06, EURUSD
hidden=1
descr=1.09930 -> 1.09936
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702592292
date2=1702592401
value1=1.099300
value2=1.099360
</object>

<object>
type=2
name=autotrade #401246722 -> #401246767, profit 0.01, EURUSD
hidden=1
descr=1.09111 -> 1.09112
color=11296515
style=2
selectable=0
ray1=0
ray2=0
date1=1702877307
date2=1702877320
value1=1.091110
value2=1.091120
</object>

<object>
type=102
name=19752label_cmnt
hidden=1
descr=Comment:
color=2631995
selectable=0
angle=0
pos_x=28
pos_y=46
fontsz=7
fontnm=Trebuchet MS
anchorpos=0
refpoint=0
</object>

<object>
type=102
name=19752label_risk
hidden=1
descr=Risk:
color=2631995
selectable=0
angle=0
pos_x=28
pos_y=64
fontsz=7
fontnm=Trebuchet MS
anchorpos=0
refpoint=0
</object>

<object>
type=2
name=M1 Trendline 34378
style=3
ray1=0
ray2=0
date1=1701114900
date2=1701121140
value1=1.094198
value2=1.093921
</object>

</window>
</chart>