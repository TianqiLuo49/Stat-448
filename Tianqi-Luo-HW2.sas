/*I'm using SAS studio for this homework*/
/*1(a)*/
title "1(a)";
proc freq data=diy;
tables agegrp * response/ nocol norow nopercent expected;
weight n;
run;

/*1(b)*/
title "1(b)";
proc freq data=diy;
tables agegrp * response/nocol norow nopercent chisq;
weight n;
run;


/*1(c)*/
title "1(c)";
proc freq data=diy;
tables agegrp * response/nopercent nocol riskdiff;
weight n;
run;

/*2(a)*/
title "2(a)";
proc freq data=diy;
tables work * response/nopercent nocol norow expected;
weight n;
run;

/*2(b)*/
title "2(b)";
proc freq data=diy;
tables work * response/nopercent nocol norow nopercent expected chisq;
weight n;
run;

/*3(a)*/
ods graphics on;
title "3(a)";
proc glm data=sashelp.iris;
class Species;
model PetalLength=Species/ss3;
means Species/hovtest;
run;
quit;
ods graphics off;
