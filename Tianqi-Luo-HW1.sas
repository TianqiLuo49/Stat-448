/*1(a)*/
proc sgplot data=sashelp.iris;
title "1(a)";
hbox PetalLength/category=Species;
run;
/*1(b)*/
title "1(b)";
proc univariate data=sashelp.iris;
var PetalLength;
probplot/normal(mu=est sigma=est);
run;
/*1(c)*/
/*make three subsets of the entire data set based on species*/
data Setosa;
set sashelp.iris;
where Species='Setosa';
run;
data Virginica;
set sashelp.iris;
where Species='Virginica';
run;
data Versicolor;
set sashelp.iris;
where Species='Versicolor';
run;
title "1(c)Setosa";
proc univariate data=Setosa;
var PetalLength;
probplot/normal(mu=est sigma=est);
run;
title "1(c)Virginica";
proc univariate data=Virginica;
var PetalLength;
probplot/normal(mu=est sigma=est);
run;
title "1(c)Versicolor";
proc univariate data=Versicolor;
var PetalLength;
probplot/normal(mu=est sigma=est);
run;
/*2(a)*/
title "2(a)";
proc univariate data=sashelp.iris mu0=45;
var PetalLength;
run;
/*2(b)*/
title "2(b)";
proc univariate data=Virginica mu0=43.50;
var PetalLength;
run;
/*2(c)*/
title "2(c)";
/*Merge datasets versicolor and Virginica*/
data versicolor_Virginica;
merge Versicolor Virginica;
by Species;
run;
proc ttest data=Versicolor_Virginica;
class Species;
var PetalLength;
run;
/*3(a)*/
title "3(a)";
ods graphics on;
proc corr data=Versicolor_Virginica;
var SepalLength SepalWidth PetalLength PetalWidth;
run;
ods graphics off;
/*3(b)*/
title "3(b)Versicolor";
ods graphics on;
proc corr data=Versicolor;
var SepalLength SepalWidth PetalLength PetalWidth;
run;
ods graphics off;
title "3(b)Virginica";
ods graphics on;
proc corr data=Virginica;
var SepalLength SepalWidth PetalLength PetalWidth;
run;
ods graphics off;






















