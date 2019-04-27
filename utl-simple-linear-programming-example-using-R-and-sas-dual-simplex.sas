Simple linear programming example using R and sas dual simplex

 Solve

   MaX fxy =  3x + 3y
   x + Y = 1
   x >= 0, y >= 0

I assume a positive integer soluton ,

Two Solutions

   1. SAS proc optmodel
      Draycut
      https://communities.sas.com/t5/user/viewprofilepage/user-id/31304

   2. R package lpsolve (several other packages available)
      https://en.proft.me/2015/09/23/classical-simplex-method-and-calc-r/


github
https://tinyurl.com/yxa98nuy
https://github.com/rogerjdeangelis/utl-simple-linear-programming-example-using-R-and-sas-dual-simplex


SAS Forum
https://tinyurl.com/yyhfsuz4
https://communities.sas.com/t5/SAS-Programming/Linear-programming-in-SAS/m-p/554479

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


*_                 _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

   MaX fxy =  3x + 3y
   x + Y = 1
   x >= 0, y >= 0

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
 ___  __ _ ___
/ __|/ _` / __|
\__ \ (_| \__ \
|___/\__,_|___/

;

X=1
Y=0

The OPTMODEL Procedure

          Solution Summary

Solver                            LP
Algorithm               Dual Simplex
Objective Function                 z
Solution Status              Optimal
Objective Value                    3

Primal Infeasibility               0
Dual Infeasibility                 0
Bound Infeasibility                0

Iterations                         0
Presolve Time                   0.00
Solution Time                   0.00


[1]    x

1      1
2      0

*____
|  _ \
| |_) |
|  _ <
|_| \_\

;

X=1
Y=0


Up to 40 obs WORK.WANT total obs=27

Obs    V1

  1
  2
  3    Results of Linear Programming / Linear Optimization
  4
  5    Objective function (Maximum): 3
  6
  7    Iterations in phase 1: 0
  8    Iterations in phase 2: 1
  9    Solution
 10      opt
 11    1   1
 12    2   0
 13
 14    Basic Variables
 15      opt
 16    1   1
 17
 18    Constraints
 19      actual dir bvec free dual dual.reg
 20    1      1  <=    1    0    3        1
 21
 22    All Variables (including slack variables)
 23        opt cvec min.c max.c marg marg.reg
 24    1     1    3     0   Inf   NA       NA
 25    2     0    3  -Inf     3    0        1
 26    S 1   0    0  -Inf     3   -3        1
 27

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

**********************
1. SAS proc optmodel *
**********************


proc optmodel;
var x{i in 1..2} >= 0;
max z = 3*x[1] +  3*x[2];
con c1: x[1] + x[2] <= 1;
solve;
print x;
run;quit;


*********************************************************
2. R package lpsolve (several other packages available) *
*********************************************************

%utl_submit_r64('
library(linprog);
library(data.table);
library(SASxport);
c = c(3,3);
b = c(1);
A = rbind(c(1,1));
res = solveLP(c, b, A, maximum=TRUE);
print(res);
outlst<-as.data.table(capture.output(print(res)));
write.xport(outlst,file="d:/xpt/outlst.xpt");
');

* R kisting to SAS dataset;
libname xpt xport "d:/xpt/outlst.xpt";
data want;
  set xpt.outlst;
run;quit;
libname xpt clear;

