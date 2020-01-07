/*I'm doing this homework on SAS studio*/
title "1(a)";
proc glm data=housing;
class over25kSqFt ptlevel taxlevel;
model logmedv=over25kSqFt ptlevel taxlevel;
run;



title "2";
proc glm data=housing;
/*add the predictors"*/
class over25kSqFt ptlevel taxlevel;
model logmedv=over25kSqFt|ptlevel|taxlevel;
lsmeans over25kSqFt|ptlevel|taxlevel /pdiff=all cl;
ods select OverallANOVA ModelANOVA LSMeans LsMeanDiffCL;
run;
/*build a new data with crime per capita <1"*/
data newhousing;
set housing;
where crim<1;
run;
/*build a simple linear regression model*/
ods graphics on;




title "3(a)";
proc reg data=newhousing;
model logmedv=age;
run;
quit;
ods graphics off;

ods graphics on;
ods listing close;
proc reg data=newhousing plots(only)=(cooksd(label)
rstudentbypredicted(label));
model logmedv=age/influence r;
run;
quit;
ods graphics off;
ods listing;


title "4(a)";
ods graphics on;
proc reg data=newhousing;
/*Using stepwise selection*/
model logmedv=age indus nox rm/selection=stepwise sle=.05 sls=.05;
ods select SelectionSummary;
run;
quit;
ods graphics off;

ods graphics on;
ods listing close;
proc reg data=newhousing plots(only)=(cooksd(label)
rstudentbypredicted(label));
model logmedv=age indus nox rm/influence r;
run;
quit;
ods graphics off;
ods listing;





