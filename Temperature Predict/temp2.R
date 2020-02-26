library(mgcv)
data<- read.table(file.choose(), sep="\t",  header=T,stringsAsFactors = FALSE,skip=1)
d<-paste(data$yyyy,"-",substr(data$month,1,3),"-1",sep="")
data$Date<-as.Date(strptime(d, "%Y-%b-%d"))
data$month<-as.numeric(format(data$Date,"%m"))

id1 <- which(substr(data$tmax, 1, 1)=="M")
id2 <- which(substr(data$tmin, 1, 1)=="M")
id3<-which(substr(data$tmin, 1, 1)!="M" & substr(data$tmax, 1, 1)!="M")

data_incomp_tmax =  data[id1, ] 
data_incomp_tmin =  data[id2, ] 
data_comp<-data[id3,]
data_comp$tmax = as.numeric(as.character(data_comp$tmax))
data_comp$tmin = as.numeric(as.character(data_comp$tmin))
data_incomp_tmin$tmax = as.numeric(as.character(data_incomp_tmin$tmax))
data_incomp_tmax$tmin = as.numeric(as.character(data_incomp_tmax$tmin))

gam_tmin = gam(tmin ~ s(month, bs = "cr", k = 12) + s(tmax),
               data = data_comp,
               family = gaussian)
pred2 = predict(gam_tmin, newdata = data_incomp_tmin)

gam_tmax = gam(tmin ~ s(month, bs = "cr", k = 12) + s(tmin),
               data = data_comp,
               family = gaussian)

pred1 = as.vector(predict(gam_tmax, newdata = data_incomp_tmax))

c1<-cbind(id1,as.vector(pred1))
c2<-cbind(id2,pred2)
full<-as.data.frame(rbind(c1,c2))
colnames(full)<-c("index","temp")
ful.or<-full[order(full$index),]
cat(ful.or$temp,sep='\n')