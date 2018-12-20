args <- commandArgs(trailingOnly = TRUE)
library(e1071)

TF = args[1]
TEST = args[2]
predfile = paste("./result/",TEST,".",TF,".MOP.txt",sep="")
TRAINFile = paste(TF,"-train-matrix.txt",sep="")
TRAIN = read.table(TRAINFile,header=F,sep="\t",check.names=FALSE)
TESTFile = paste(TF,"-",TEST,"-matrix.txt",sep="")
TEST = read.table(TESTFile,header=F,sep="\t",check.names=FALSE)
TRAIN = TRAIN[, colSums(is.na(TRAIN)) != nrow(TRAIN)]
TEST = TEST[, colSums(is.na(TEST)) != nrow(TEST)]		
trainchip = as.numeric(TRAIN[,2])
trainmax= max(trainchip)
trainmin = min(trainchip)
trainlabel = (trainchip-trainmin)/(trainmax-trainmin)
MATRIXTrain = as.matrix(TRAIN[,-c(1:2)])
trainmatrix = matrix(as.numeric(MATRIXTrain),nrow=nrow(MATRIXTrain))
MATRIXTest = as.matrix(TEST[,-c(1)])
id = TEST[,1]
id = as.vector(id)
testmatrix = matrix(as.numeric(MATRIXTest),nrow=nrow(MATRIXTest)) 
model  = svm(x = trainmatrix,y = trainlabel)
pred = predict(model,testmatrix)
predf = as.vector(pred)
predtable = cbind(id,predf)
write.table (predtable,predfile,quote=F,sep="\t",col.names = F, row.names = F)
