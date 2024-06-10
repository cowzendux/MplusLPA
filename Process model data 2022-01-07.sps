* Encoding: UTF-8.
* Process Model subprogram
* by Jamie DeCoster

* This program takes a dataset of LPA model statistics and adds variables 
* representing LMR change statistics.

compute neg2LL = -2*LL.
compute priorNeg2LL = -2*lag(LL).
compute priorParam = lag(FreeParam).
compute LMR = priorNeg2LL - neg2LL.
compute LMR_df = FreeParam - priorParam.
compute LMR_p = 1-cdf.chisq(LMR, LMR_df).
execute.

********
* Version History
********.
* 2022-01-07 Created
