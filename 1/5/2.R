install.packages("sampling")
library(sampling)
data(MU284)
table(MU284$REG) # Tabela com qnt de mun em cada regiao

prop.table(table(MU284$REG)) # Peso de cada estrato


set.seed(3)
selec = strata(MU284, stratanames = "REG", size = c(8,14,10,11,16,12,5,9),
               method = 'srswor')

selec

head(selec, 10) # As 10 primeiras unid selec pela AE

selec$Prob

amostra = getdata(MU284, selec)
head(amostra, 8)


fpc = rep(c(25,48,32,38,56,41,15,29), c(8,14,10,11,16,12,5,9))
fpc




install.packages("survey")
library(survey)
plano_est = svydesign(id = ~1, strata = ~Stratum, probs = ~selec$Prob, 
                      data = amostra, fpc = ~fpc)

svymean(~P85, plano_est) # Estimativa da média e seu erro padrao pra variavel P85
svytotal(~P85, plano_est) # Estimativa do total e seu erro padrao para variavel P85


# Com PESO no lugar de prob
amostra$PESO = 1/amostra$Prob
plano_est2 = svydesign(id= ~1, strata = ~Stratum, weights = ~PESO,
                       data = amostra, fpc = ~fpc)

svymean(~P85, plano_est2)
svytotal(~P85, plano_est2)


# SEM FPC
plano_est3 = svydesign(id= ~1, strata = ~Stratum, probs = ~selec$Prob,
                       data = amostra) 

svymean(~P85, plano_est3)
svytotal(~P85, plano_est3)

# ESTIMAÇÃO POR ESTRATO
svyby(~P85, by = ~Stratum, design = plano_est, FUN = svymean)
svyby(~P85, by = ~Stratum, design = plano_est, FUN = svytotal)
