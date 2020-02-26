# Enter your code here. Read input from STDIN. Print output to STDOUT
#test<-read.table("stdin", sep="", header=FALSE,fill = NA,col.names = c("charge"))
train<- read.table("trainingdata.txt", sep=",", header=FALSE,fill = NA,col.names = c("charge","last"))
plot(y=train$last,x=train$charge)
colnames(test)<-"charge"
#, sep="", header=FALSE,fill = NA,col.names = c("charge"))
#ch.we<-ifelse(train$charge>4, 1, 0)

plot(y=train$last,x=train$charge)

fit<-lm(last~charge*I(ifelse(charge>4, 1, 0)),data=train)
pre<-predict.lm(fit,newdata = test)
cat(round(pre,2),sep='\n')
