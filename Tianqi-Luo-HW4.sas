/*1(a)*/
title "1(a)";
proc freq data=autos;
tables fuel*cityover30mpg;
run;
proc freq data=autos;
tables drive*cityover30mpg;
run;
proc freq data=autos;
tables cylinders*cityover30mpg;
run;

/*1(b)*/
title "1(b)";
proc logistic data=autos;
class fuel drive cylinders;
model cityover30mpg=fuel drive cylinders/selection=stepwise sle=.05 sls=.05;
ods select OddsRatios ParameterEstimates GlobalTests ModelInfo FitStatistics;
run;
/*fuel and drive are the remaining factors*/
title "1(c)";
proc logistic data=autos;
class fuel drive;
model cityover30mpg=fuel drive/lackfit;
ods select OddsRatios ParameterEstimates GlobalTests ModelInfo FitStatistics LackFitChiSq;
run;

title "2(a)";
proc logistic data=autos;
model cityover30mpg=price1k rpm enginesize hp;
ods select OddsRatios ParameterEstimates GlobalTests ModelInfo FitStatistics;
run;


title"2(b)";
/*2(b)*/
proc logistic data=autos;
model cityover30mpg=price1k rpm enginesize hp/selection=stepwise sle=0.05 sls=0.05;
ods select OddsRatios ParameterEstimates GlobalTests ModelInfo FitStatistics;
run;
/*only enginesize remains*/
title "2(c)";
proc logistic data=autos;
model cityover30mpg=hp/lackfit;
ods select OddsRatios ParameterEstimates GlobalTests ModelInfo FitStatistics LackFitChiSq;
run;

/*3(a)*/
title "3(a)";
proc glm data=autos;
class price1k rpm fuel drive enginesize hp cylinders;
model hwaympg=price1k rpm fuel drive enginesize hp cylinders/ss3 ss1;
ods select OverallANOVA FitStatistics ModelANOVA;
run;
title "3(b)";
proc glm data=autos;
class price1k;
model hwaympg=price1k/ss3 ss1;
ods select OverallANOVA FitStatistics ModelANOVA;
run;


