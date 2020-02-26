library(forecast)#stdin
library(zoo)
calcMissing <- function(readings) {
  yearss<-c()
  tmaxx<-c()
  tminn<-c()
  monthh<-c()
  
  for (i in 1:length(readings)){
    lines <- unlist(strsplit(readings[i], sp = "\t"))
    yearss[i]<-lines[1]
    monthh[i]<-lines[2]
    tmaxx[i]<-ifelse(substr(lines[3],1,1)=="M",NA,as.numeric(lines[3]))
    tminn[i] <-ifelse(substr(lines[4],1,1)=="M",NA,as.numeric(lines[4]))
  } 
  
  data=data.frame(yyyy=yearss,mont=monthh, tmax=tmaxx,tmin=tminn)
  #Date=as.POSIXct(datess,format = "%m/%d/%Y %H:%M:%S")
  ts1<- ts(data$tmax)
  ts2<-ts(data$tmin)
  
  d<-paste(data$yyyy,"-",substr(data$month,1,3),"-1",sep="")
  data$date<-as.Date(strptime(d, "%Y-%b-%d"))
  ind<-seq(1,nrow(data),1)
  id1.na <- which(is.na(ts1))
  id2.na <- which(is.na(ts2))
  
  
  in.tmax<-as.vector(na.interp(ts1,lambda = "auto"))
  in.tmin<-as.vector(na.interp(ts2,lambda = "auto"))
  
  c1<-cbind(id1.na,in.tmax[id1.na])
  c2<-cbind(id2.na,in.tmin[id2.na])
  full<-as.data.frame(rbind(c1,c2))
  colnames(full)<-c("index","temp")
  ful.or<-full[order(full$index),]
  cat(ful.or$temp,sep='\n')
}


data<- read.table(file.choose(), sep="\t",  header=T,stringsAsFactors = FALSE,skip=1)
#data$Date=strptime(data$Date,format = "%m/%d/%Y %H:%M:%S")
data$tmax <-ifelse(substr(data$tmax,1,1)=="M",NA,data$tmax)
data$tmin <-ifelse(substr(data$tmin,1,1)=="M",NA,data$tmin)
data$tmax=as.numeric(data$tmax)
data$tmin=as.numeric(data$tmin)
ts1 = ts(data$tmax)
ts2<-ts(data$tmin)
#y=ts

d<-paste(data$yyyy,"-",substr(data$month,1,3),"-1",sep="")
data$Date<-as.Date(strptime(d, "%Y-%b-%d"))
ind<-seq(1,nrow(data),1)
id1.na <- which(is.na(ts1))
id2.na <- which(is.na(ts2))

in.tmax<-as.vector(na.interp(ts1,lambda = "auto"))
in.tmin<-as.vector(na.interp(ts2,lambda = "auto"))

c1<-cbind(id1.na,in.tmax[id1.na])
c2<-cbind(id2.na,in.tmin[id2.na])
full<-as.data.frame(rbind(c1,c2))
colnames(full)<-c("index","temp")
ful.or<-full[order(full$index),]
cat(ful.or$temp,sep='\n')
###############################################
library(splines)


fit1=interpSpline(ind[-(id1.na)],ts1[-(id1.na)])
fo1<-as.data.frame(predict(fit1,ind[(id1.na)]))
fit2=interpSpline(ind[-(id2.na)],ts2[-(id2.na)])
fo2<-as.data.frame(predict(fit2,ind[(id2.na)]))
full<-as.data.frame(rbind(fo1,fo2))
colnames(full)<-c("index","temp")
ful.or<-full[order(full$index),]
cat(ful.or$temp,sep='\n')

###########################################
fit1=smooth.spline(x=ind[-(id1.na)],y=ts1[-(id1.na)],all.knots = T)
fo1<-as.data.frame(predict(fit1,ind[(id1.na)]))
fit2=smooth.spline(x=ind[-(id2.na)],y=ts2[-(id2.na)],all.knots = T)
fo2<-as.data.frame(predict(fit2,ind[(id2.na)]))
full<-as.data.frame(rbind(fo1,fo2))
colnames(full)<-c("index","temp")
ful.or<-full[order(full$index),]
cat(ful.or$temp,sep='\n')

##################################################
in.tmax<-as.vector(na.approx(ts1,rule=2))
in.tmin<-as.vector(na.approx(ts2,rule=2))

c1<-cbind(id1.na,in.tmax[id1.na])
c2<-cbind(id2.na,in.tmin[id2.na])
full<-as.data.frame(rbind(c1,c2))
colnames(full)<-c("index","temp")
ful.or<-full[order(full$index),]
cat(ful.or$temp,sep='\n')

#########################################################

in.tmax<-as.data.frame(spline(ind,ts1,n=length(ind)))
in.tmin<-as.data.frame(spline(ind,ts2,n=length(ind)))

c1<-in.tmax[id1.na,]
c2<-in.tmax[id2.na,]
full<-as.data.frame(rbind(c1,c2))
colnames(full)<-c("index","temp")
ful.or<-full[order(full$index),]
cat(ful.or$temp,sep='\n')
