library(sampling)
data(MU284)
dados = MU284
table(MU284$CL)

set.seed(5)
ACS = cluster(MU284, clustername = c('CL'), size = 14, method = c('srswor'))
head(ACS,10)
ACSs=getdata(MU284,ACS)
fix(ACSs)             

fpc2=rep(50,dim(ACSs)[1])
fpc2


library(survey)
PlanoC= svydesign(ids=~CL,data = ACSs, probs = ACS$Prob, fpc = fpc2)
PlanoC

svymean(~P85, PlanoC)
svytotal(~P85, PlanoC)



# Outra forma de obter os mesmos resultados

peso=1/ACS$Prob
ACS$Prob
peso

PlanoC2= svydesign(ids = ~CL,data = ACSs,weights = peso,fpc = fpc2)
svymean(~P85, PlanoC2)
svytotal(~P85, PlanoC2)



# Resultados sem o fpc

planoC_sem_fpc = svydesign(id= ~CL, data=ACSs,weights = peso)
svymean(~P85, planoC_sem_fpc)
svytotal(~P85, planoC_sem_fpc)
