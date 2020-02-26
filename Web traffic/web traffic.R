data<- read.table(file.choose(),header=FALSE,skip=1,fill = NA,stringsAsFactors = F,col.names = "traffic")

#auto.arima(data)
#pred<-as.vector(forecast(fit,h = 30)$mean)

#ts.plot(ts(diff(data$traffic))))

#acf(diff(data$traffic))
#pacf(diff(data$traffic))
#diff(data$traffic,differences = 1)


fit1<-arima(data$traffic,order = c(3,1,4))#
pred<-predict(fit1,n.ahead=30,se.fit = F)
pred<-as.numeric(pred)
pred[9:30]<-pred[9:30]-1000
cat(as.numeric(pred),sep="\n")


