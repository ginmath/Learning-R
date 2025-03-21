# Exercicio 1

set.seed(5)
(k<- round((1/10)*100))

(r<- sample(seq(1,k,1),1))

c(r,r+k,r+2*k, r+788*k, r+789*k)



# Exercicio 2

library(sampling)
data("belgianmunicipalities")
N=nrow(belgianmunicipalities)
N
table(belgianmunicipalities$Province)

set.seed(10)
ACS = cluster(belgianmunicipalities, clustername = c('Province'), size = 3, method = c('srswor'))
ACSs=getdata(belgianmunicipalities,ACS)
             

fpc2=rep(9,dim(ACSs)[1])


library(survey)
Plano_ACS= svydesign(ids=~Province,data = ACSs, probs = ACS$Prob, fpc = fpc2)
PlanoC

svymean(~averageincome, Plano_ACS)
svytotal(~averageincome, Plano_ACS)
