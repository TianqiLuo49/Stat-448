data heart;
infile '/home/tianqiluo490/Stat 448/Final Project/Statistics.txt' dlm=',';
input bhr basebp basedp pkhr sbp dp dose maxhr per_mphrb mbp dpmaxdo dobdose age gender baseEF dobEF chestpain posECG equivecg restwma posSE
newMI newPTCA newCABG death hxofHT hxofdm hxofcig hxoFMI hxofPTCA hxofCABG anyevent phat event mics deltaEF newpkmphr gdpkmphr gdmaxmphr gddpeakdp gdmaxdphardness;
drop phat event mics deltaEF newpkmphr gdpkmphr gdmaxmphr gddpeakdp gdmaxdphardness;
run;
/*In this presentation, my topic is "How well can we predit peak heart rate using some of the
continuous variables, in this case, I choose bhr, basebp, pkhr, sbp, dose, maxhr,per_mphrb, mbp, dobdose, age"*/
/*plot the scatterplot for the response and all the predictors*/
title "scatterplot";
proc sgplot data=heart;
scatter x=bhr y=pkhr;
run;

proc sgplot data=heart;
scatter x=basebp y=pkhr;
run;

proc sgplot data=heart;
scatter x=sbp y=pkhr;
run;

proc sgplot data=heart;
scatter x=dose y=pkhr;
run;

proc sgplot data=heart;
scatter x=maxhr y=pkhr;
run;

proc sgplot data=heart;
scatter x=per_mphrb y=pkhr;
run;

proc sgplot data=heart;
scatter x=dobdose y=pkhr;
run;

proc sgplot data=heart;
scatter x=age y=pkhr;
run;

/*use simple linear regression for the model*/
/*Fit a simple linear regression model and the predictors*/
title "first model";
proc reg data=heart;
model pkhr=bhr basebp sbp dose maxhr per_mphrb mbp dobdose age;
output out=heart_out Cookd=cd;
ods select ANOVA ParameterEstimates FitStatistics DiagnosticsPanel;
run;

title "eliminate cook's distance";
/*eliminate the cook's distance bigger than 0.02*/
proc reg data=heart_out;
model pkhr=bhr basebp sbp dose maxhr per_mphrb mbp dobdose age;
where cd<0.02;
ods select ANOVA ParameterEstimates FitStatistics DiagnosticsPanel;
run;

/*use backward selection to find the best model*/
title "backward selection";
proc reg data=heart;
model pkhr=bhr basebp sbp dose maxhr per_mphrb mbp dobdose age/selection=backward sls=0.05;
run;

title "forward selection";
/*use forward selection to find the best model*/
proc reg data=heart;
model pkhr=bhr basebp sbp dose maxhr per_mphrb mbp dobdose age/selection=forward sle=0.05;
run;
/*the significant variables are maxhr mbp and dobdose*/
/*use stepwise selection to find the best model*/

title "stepwise selection";
proc reg data=heart;
model pkhr=bhr basebp sbp dose maxhr per_mphrb mbp dobdose age/selection=stepwise sle=.05 sls=.05;
ods  select SelectionSummary DiagnosticsPanel;
run; 

/*build a model with the remaining variables*/
title "remaining variables";
proc reg data=heart;
model pkhr=maxhr mbp sbp;
output out=heart_out2 CookD=cd2;
ods select ods select ANOVA ParameterEstimates FitStatistics DiagnosticsPanel;
run;

/*make adjustment based on the Cook's distance, compare the AIC and the R-squared*/
title "make adjustment based on Cook's D and compare AIC"
proc reg data=heart_out2;
model pkhr=maxhr mbp sbp;
where cd2<0.01;
ods select ANOVA ParameterEstimates FitStatistics DiagnosticsPanel;
run;











