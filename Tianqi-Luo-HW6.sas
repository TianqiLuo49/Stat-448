/*1(a)*/
title "1(a)";
proc cluster data=cars2 method=average pseudo ccc print=10;
var EngineSize HorsePower MPG_City MPG_Highway Weight Wheelbase Length;
copy Type logMSRP;
ods select Dendrogram ClusterHistory CccPsfAndPsTSqPlot;
run;


/*1(b)*/
title "1(b)";
proc tree ncl=3 out=cars2result noprint;
copy Type EngineSize HorsePower MPG_City MPG_Highway Weight Wheelbase Length logMSRP;
run;
proc sgplot data=cars2result;
scatter x=Length y=TYPE/group=cluster datalabel=Type;
run;


/*1(c)*/
title "1(c)";
proc sort data=cars2result;
by cluster;
run;
proc means data=cars2result;
by cluster;
run;

/*2(a)*/
title "2(a)";
proc univariate data=cars2result normal;
var logMSRP;
by cluster;
ods select TestsForNormality;
run;

/*2(b)*/
title "2(b)";
proc anova data=cars2result;
class CLUSTER;
model logMSRP=CLUSTER;
ods select FitStatistics OverallANOVA BoxPlot;
run;

/*3(a)*/
title "3(a)";
proc discrim data=cars2 pool=test crossvalidate manova;
class Type;
var EngineSize HorsePower MPG_City MPG_Highway Weight Wheelbase Length  logMSRP;
ods select ClassifiedCrossVal ErrorCrossVal MultStat;
run;

/*3(b)*/
title "3(b)";
proc stepdisc data=cars2 sle=0.05 sls=0.05;
class Type;
var EngineSize HorsePower MPG_City MPG_Highway Weight Wheelbase Length logMSRP;
ods select Summary;
run;
/*according to the stepwise discrimination, MPG_City, MPG_Highway, Weight, Wheelbase, Length 
and logMSRP are left in the final variables*/

proc discrim data=cars2 pool=test crossvalidate manova;
class Type;
var MPG_City MPG_Highway Weight Wheelbase Length logMSRP;
ods select ClassifiedCrossVal ErrorCrossVal;
run;



/*build a new data cars2new*/
data cars2new;
set cars2;
if Type='Sedan' then Sedanvar=1;
else Sedanvar=0;
run;

/*4(a)*/
title "4(a)";
proc discrim data=cars2new pool=test crossvalidate manova;
class Type;
var EngineSize HorsePower MPG_City MPG_Highway Weight Wheelbase Length logMSRP Sedanvar;
ods select ClassifiedCrossVal ErrorCrossVal MultStat;
run;

/*4(b)*/
title "4(b)";
proc stepdisc data=cars2new sle=0.05 sls=0.05;
class Type;
var EngineSize HorsePower MPG_City MPG_Highway Weight Wheelbase Length  logMSRP Sedanvar;
ods select Summary;
run;

/*According to stepwise, Sedanvar, Wheelbase, Weight, logMSRP, MPG_Highway remain*/

proc discrim data=cars2new pool=test crossvalidate manova;
class Type;
var  MPG_Highway Weight Wheelbase  logMSRP Sedanvar;
ods select ClassifiedCrossVal ErrorCrossVal;
run;
 































