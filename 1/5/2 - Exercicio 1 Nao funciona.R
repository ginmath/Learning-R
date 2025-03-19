library(sampling)
library(survey)

data(MU284)
N <- nrow(MU284)
n <- 50

table(MU284$REG)
50*prop.table(table(MU284$REG))

set.seed(3)
selec = strata(MU284, stratanames = "REG", size = c(5,9,6,7,10,8,3,6),
               method = 'srswor')
amostra <- getdata(MU284, selec)

fpc = rep(c(25,48,32,38,56,41,15,29), c(5,9,6,7,10,8,3,6))
design <- svydesign(ids = ~1, strata = ~Stratum, probs = ~select$Prob, data = amostra, fpc = ~fpc

estimativa <- svymean(~RMT85, design = design)

print(estimativa)