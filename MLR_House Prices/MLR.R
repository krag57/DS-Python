# Enter your code here. Read input from STDIN. Print output to STDOUT
data<- read.table('stdin', sep="", header=FALSE,fill = NA)
f<-data[1,1]
xnam <- paste("x", 1:(f+1), sep="")
xnam[(f+1)]<-"y"
colnames(data)<-xnam

n<-data[1,2]
t<-data[(n+2),1]
train<-data[(2:(n+1)),(1:(f+1))]
test<-data[((n+3):nrow(data)),1:f]

fmla <- as.formula(paste("y ~ ", paste(xnam[-(f+1)], collapse= "+")))
#x=as.matrix(train[,(1:f)])
fit<-lm(fmla,data =train)

x=test
pre<-predict.lm(fit, newdata = test)
cat(round(pre,2),sep='\n')

