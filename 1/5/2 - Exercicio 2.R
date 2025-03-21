library(sampling)
data("belgianmunicipalities")
N = nrow(belgianmunicipalities)
n = 300


table(belgianmunicipalities$Province)
300*prop.table(table(belgianmunicipalities$Province))

set.seed(5)
selec = strata(belgianmunicipalities, stratanames = 'Province',
               size = c(36,57,33,34,36,43,23,23,20), method = 'srswor')
amostra = getdata(belgianmunicipalities, selec)
fpc = rep(c(70,111,64,65,69,84,44,44,38), c(36,57,33,34,36,43,23,23,20))


library(survey)
plano_est = svydesign(ids = ~1, strata = ~Province, probs = ~selec$Prob, data = amostra, fpc = ~fpc)
svyby(~averageincome, by = ~Province, design = plano_est, FUN = svymean)


plano_est2 = svydesign(ids = ~1, strata = ~Province, probs = ~selec$Prob, data = amostra)
svyby(~averageincome, by = ~Province, design = plano_est2, FUN = svymean)
