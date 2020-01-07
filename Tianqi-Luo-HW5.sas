/*1(a)*/
title "1(a)";
proc genmod plots=CooksD;
class fuel drive cylinders;
model hwaympg = fuel drive hp enginesize cylinders;
output Cookd=cd;
ods exclude ModelInfo ModelFit ParameterEstimates ClassLevels NObs;
run;


/*1(b)*/
title "1(b)";
proc genmod plots=Reschi;
class fuel drive cylinders;
model hwaympg = fuel drive hp enginesize cylinders;
where cd<1.0;
output out=diaga Reschi=ri;
ods exclude ModelInfo ModelFit ParameterEstimates ClassLevels NObs;
run;
/*1(c)*/
/*after removing data with large Cook's D and big residuals, we get the final model diaga*/
title "1(c)-My final model";
proc genmod data=diaga;
class fuel drive cylinders;
model hwaympg = fuel drive hp enginesize cylinders;
where ri<5 & ri>-5;
output out=diaga2;
ods select ModelInfo ModelFit ParameterEstimates;
run;
/*final model diaga2*/
/*compare with HW4 model*/
title "1(c)-HW4 model";
proc genmod data = autos;
	class fuel drive cylinders;
	model hwaympg = fuel drive hp enginesize cylinders/ dist=p dscale type1 type3;
	ods select ParameterEstimates ModelInfo ModelFit;
run;


/*2(a)*/
title "2(a)";
proc corr data=life;
run;

proc princomp data=life;
id country;
run;

/*2(c)*/
title "2(c)";
proc princomp data=life plots= score(ellipse ncomp=3);
id country;
ods select ScorePlot;
run;

/*3(a)*/
title "3(a)";
proc princomp data=life covariance out=pout;
id country;
run;

/*3(c)*/
title "3(c)";
proc princomp data=life covariance plots= score(ellipse ncomp=2);
id country;
ods select ScorePlot;
run;



/*4(a)*/
title "4(a)";
proc cluster data=pout outtree=clustera
method=average ccc pseudo print=15;
var Prin1 Prin2 Prin3 Prin4 Prin5 Prin6 Prin7 Prin8;
id country;
run;

/*4(b)*/
title "4(b)";
proc tree noprint ncl=2 out=out;
copy Prin1 Prin2;
id country;
run;
proc print data=out;
run;

/*4(c)*/
title "4(c)";
proc sgplot data=out;
scatter y=Prin2 x=Prin1/group=cluster datalabel=country;
run;













