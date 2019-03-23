#########################################################################
# PCA_Plot functions
#########################################################################

PCA_Plot = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = data.frame(pcaData$rotation, .names = row.names(pcaData$rotation))
  p + geom_text(data=loadings, mapping=aes(x = PC1, y = PC2, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC1", y = "PC2")
}

PCA_Plot_Secondary = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = data.frame(pcaData$rotation, .names = row.names(pcaData$rotation))
  p + geom_text(data=loadings, mapping=aes(x = PC3, y = PC4, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC3", y = "PC4")
}

PCA_Plot_Psyc = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = as.data.frame(unclass(pcaData$loadings))
  s = rep(0, ncol(loadings))
  for (i in 1:ncol(loadings))
  {
    s[i] = 0
    for (j in 1:nrow(loadings))
      s[i] = s[i] + loadings[j, i]^2
    s[i] = sqrt(s[i])
  }
  
  for (i in 1:ncol(loadings))
    loadings[, i] = loadings[, i] / s[i]
  
  loadings$.names = row.names(loadings)
  
  p + geom_text(data=loadings, mapping=aes(x = PC1, y = PC2, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC1", y = "PC2")
}

PCA_Plot_Psyc_Secondary = function(pcaData)
{
  library(ggplot2)
  
  theta = seq(0,2*pi,length.out = 100)
  circle = data.frame(x = cos(theta), y = sin(theta))
  p = ggplot(circle,aes(x,y)) + geom_path()
  
  loadings = as.data.frame(unclass(pcaData$loadings))
  s = rep(0, ncol(loadings))
  for (i in 1:ncol(loadings))
  {
    s[i] = 0
    for (j in 1:nrow(loadings))
      s[i] = s[i] + loadings[j, i]^2
    s[i] = sqrt(s[i])
  }
  
  for (i in 1:ncol(loadings))
    loadings[, i] = loadings[, i] / s[i]
  
  loadings$.names = row.names(loadings)
  
  print(loadings)
  p + geom_text(data=loadings, mapping=aes(x = PC3, y = PC4, label = .names, colour = .names, fontface="bold")) +
    coord_fixed(ratio=1) + labs(x = "PC3", y = "PC4")
}

#setwd("/Users/deeps/Documents/CSC 424 Advance Data Analysis/Assignments/Project")
setwd("C:/Users/RMARAM/Downloads")
install.packages("car")
install.packages("QuantPsyc")
install.packages("leaps")
library(car)
library(QuantPsyc)
library(leaps)

#Loading the data set
install.packages("readxl")
library(readxl)
auto_data = read_excel("AutomobileFinal.xlsx")
dim(auto_data)
str(auto_data)

#Extracting the numeric variables
newdata <- auto_data[c(10,11,12,13,14,17,19,20,21,22,23,24,25,26)]

#Structure of the data
str(newdata)
dim(newdata)

#Correlations
corData <- cor(newdata)


#Correlation Coefficents
print(round(corData, digits=2))

# find attributes that are highly corrected (ideally >0.75)
#highlyCorrelated <- findCorrelation(corData, cutoff=0.7)

# print indexes of highly correlated attributes
#print(highlyCorrelated)

#Removing the highly correlated variables
#train <- newdata[-c(5, 2, 3, 6, 13, 12)]
#str(train)

#Check for Zero variance and remove them
library(caret)
x = nearZeroVar(train, saveMetrics = TRUE)
x[ x[,"nzv"] > 0, ] # Determine near zero values
number_of_var_rmv=  nrow (x[ x[,"nzv"] > 0, ])
remove_columns= rownames(x[ x[,"nzv"] > 0, ]) #get names
count_of_small_variance= length(remove_columns)
remove_col_num = which (colnames(train) %in% remove_columns ) 
train_novar=train [, -remove_col_num ]
colnames(train_novar)


#Checking for zero variance if any
badCols <- nearZeroVar(newdata)
str(badCols)

#Calculating Correlations
cor_data = cor(train)
cor_data
library(corrplot)
corrplot(cor_data, method="circle", type = "full")

#Principal Components
prComp = prcomp(train, center=T, scale=T)
screeplot(prComp)
abline(1, 0)
summary(prComp)
print(prComp)

#Plots for PCA
par(mar=c(2, 2, 2, 2))
plot(prComp)
PCA_Plot_Secondary(prComp)
biplot(prComp)

#Selecting 3 components
p1 = psych::principal(train, rotate="varimax", nfactors=3, scores=TRUE)
p1
#Loading with sorting
print(p1$loadings, cutoff=.4, sort=T)
#Loading without sorting
p1$loadings
p1$values
#shared variance
p1$communality
#Matrix after rotation
p1$rot.mat

#Scores
pscore=p1$scores
min(pscore[,1])
max(pscore[,1])
min(pscore[,2])
max(pscore[,2])
min(pscore[,3])
max(pscore[,3])

#####################################################################
#Principal Component Regression
#####################################################################

#install.packages("pls")
#Regression with PCA
library(pls)
pcr_model <- pcr(price~., data = train, scale = TRUE, validation = "CV")
summary(pcr_model)
# Plot the root mean squared error
validationplot(pcr_model)

# Plot the cross validation MSE
validationplot(pcr_model, val.type="MSEP")

predplot(pcr_model)

coefplot(pcr_model)

#Spliting training set into two parts based on outcome: 80% and 20%
index <- createDataPartition(newdata$price, p=0.80, list=FALSE)
trainSet <- newdata[ index,]
testSet_y <- newdata[-index, 14]
testSet_x <- newdata[-index, 1:13]
str(testSet)

pcr_model <- pcr(price~., data = trainSet, scale = TRUE, validation = "CV")
summary(pcr_model)

pcr_pred <- predict(pcr_model, testSet_x, ncomp = 4)

mean((pcr_pred - testSet_y$price)^2)


#############################################
#PCA MIX fro Categorical Variables#
#############################################

setwd("C:/Users/RMARAM/Downloads")

#Loading the data set
#install.packages("readxl")
library(readxl)
auto_data = read_excel("AutomobileFinal.xlsx")
dim(auto_data)
str(auto_data)

#install.packages("PCAmixdata")
library(PCAmixdata)

head(auto_data)
split <- splitmix(auto_data)
X1 <- split$X.quanti 
X2 <- split$X.quali
res.pcamix <- PCAmix(X.quanti=X1, X.quali=X2,rename.level=TRUE,
                     graph=FALSE)
res.pcamix

#The variance of the principal components is obtained.
res.pcamix$eig
res.pcamix$coef
res.pcamix$sqload

res.pcarot <- PCArot(res.pcamix,dim=6,graph=FALSE)
res.pcarot$eig 

sum(res.pcarot$eig[,2])
res.pcarot

round(res.pcamix$sqload[,1:5],digit=2)
round(res.pcarot$sqload,digit=2)

