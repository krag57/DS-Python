# Enter your code here. Read input from STDIN. Print output to STDOUT
#data<- read.table(file.choose(), sep="", header=FALSE,fill = NA)
calcMissing <- function(readings,readings_test) {
  fLine<-unlist(strsplit(readings[1], sp = "\t"))
  f<-as.numeric(fLine[1])
  n<-as.numeric(fLine[2])
  trList=teList<-list()
  
  for (i in 2:n){
  lines <- unlist(strsplit(readings[i], sp = "\t"))
    for (j in 1:(f+1)){
    trList[[j]][i]<-as.numeric(lines[j])
    }
  }
  fLine1<-unlist(strsplit(readings_test[1], sp = "\t"))
  n1<-as.numeric(fLine1[2])
  for (i in 2:n1){# if 1st is just a number
    lines <- unlist(strsplit(readings_test[i], sp = "\t"))#test list
    for (j in 1:(f)){
      teList[[j]][i]<-as.numeric(lines[j])
    }
  } 
  
train<-do.call(rbind.data.frame, trList)
test<-do.call(rbind.data.frame, teList)

xnam <- paste("x", 1:(f), sep="")
pol<-paste("poly(",xnam,sep="")
polf<-paste(pol,",",4,")",sep="")

k=3
co<-xnam
for(i in 1:f){
  co<-c(co,paste("I(",xnam[i],"^",2:k,")",sep=""))
}



form<-c()
fff<-list()
for(i in 1:k){
 fff<- c(fff,apply(combn(co,i),2, function(x) as.formula(paste("y ~ ", paste(x, collapse= "+")))))

}
colnames(test)<-xnam

xnam[(f+1)]<-"y"
colnames(train)<-xnam

MSR<-c()
for(j in 1:length(fff)){
  fite<-lm(fff[[j]],data =train)$residuals
  MSR[j]<-max(abs(fite)/train$y)
}

m<-which.min(MSR)
fit<-lm(fff[[m]],data =train)
pre<-predict.lm(fit, newdata = test)
cat(round(pre,2),sep='\n')
}


  
  