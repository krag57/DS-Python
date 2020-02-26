library(forecast)
data<- read.table(file.choose(), sep="", header=FALSE,fill = NA,stringsAsFactors = F)
m<-data[1,1]
k<-data[1,2]
d<-data[1,3]

new<-as.data.frame(data[-1,])
#trades<-new[,-(1:2)]
res<-c()
dif<-c()
for(i in 1:nrow(new)){
  #i=1
  fi_da<-as.numeric(new[i,-(1:2)])
  fit<-auto.arima(fi_da)
  pre<-forecast(fit,h=1)
  dif[i]<-round(as.numeric(pre$mean)-fi_da[length(fi_da)],2)
  if (as.numeric(pre$mean)>=fi_da[length(fi_da)]) res[i]<-"BUY" else res[i]<-"SELL"
}
results<-data.frame(dif,res)
#results[order(results$dif,decreasing = F),]
#which(res=='BUY')
#new[which(res=='BUY'),ncol(new)]
#round(new[which(res=='BUY'),2],0)

resultsnew<-data.frame((new[,1]),res,rep(0),stringsAsFactors = F)
write(k,file = "stdout")
write.table(resultsnew,file = "stdout",quote = F,append = T,row.names = F,col.names = F,sep = " ")
