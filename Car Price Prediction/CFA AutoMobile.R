
library(foreign)  # Allows us to read spss files!
library(corrplot)
library(car)
library(QuantPsyc)
library(leaps)
library(xlsx)

# Set the working directory
setwd("C:/Users/VIVEK/Documents/CSC 424 Stephenie Besser")
automob<- read.xlsx("AutomobileFinal.xlsx", sheetIndex = 1,startRow = 1 ,header = TRUE)
head(automob)
dim(automob)
str(automob)

#keeping numreric only.
AutoNumeric = automob[, c(10,11,12,13,14,17,19,20,21,22,23,24,25,26)]

#removing the na values
AutoNumeric<- na.omit(AutoNumeric)
head(AutoNumeric)
dim(AutoNumeric)

#check for screeplot.
p = prcomp(AutoNumeric, center=T, scale=T)
screeplot(p)
abline(1, 0)
summary(p)
print(p)

#PCA
#p2 = psych::principal(AutoNumeric, rotate="varimax", nfactors=3, scores=TRUE)
#p2
#print(p2$loadings, cutoff=.4, sort=T)

#Factor Analysis
fit = factanal(AutoNumeric, 3)
print(fit$loadings, cutoff=.4, sort=T)
summary(fit)
