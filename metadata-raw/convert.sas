libname here ".";
proc export data=here.ssb_v7_0_synthetic_new_vars dbms=dta outfile="ssb_v7_0_synthetic_new_vars.dta" replace;
run;

