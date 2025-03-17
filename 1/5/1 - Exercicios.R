set.seed(7)
sample(1:45965, 5)

set.seed(7)
s=srswor(5,45965)
(1:45965)[s!=0]



library(sampling)
data("belgianmunicipalities")
fix(belgianmunicipalities)
N = nrow(belgianmunicipalities)
n = 200

set.seed(2)
selec = sample(1:N, n)
amostra = belgianmunicipalities[selec,]

library(survey)
amostra$N = N
AAS = svydesign(id = ~1, data= amostra, fpc = ~N)
AAS
svymean(~averageincome, AAS)
