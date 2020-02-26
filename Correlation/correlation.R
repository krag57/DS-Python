data<- read.table(file.choose(), sep="\t",skip = 1, header=F,col.names=c("M","P","C"))

p.cor<-function(x1,x2) {
  num<-(length(x1)*sum(x1*x2))-(sum(x1)*sum(x2))
  d1<-sqrt((length(x1)*sum(x1^2))-(sum(x1))^2)
  d2<-sqrt((length(x2)*sum(x2^2))-(sum(x2))^2)
  return (round(num/(d1*d2),2))
}

co<-c()
co[1]<-p.cor(data$M,data$P)
co[2]<-p.cor(data$P,data$C)
co[3]<-p.cor(data$M,data$C)

cat(co,sep='\n')
cor
