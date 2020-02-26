library(forecast)#stdin
#data<- read.table(file.choose(), sep="\t", header=FALSE, skip=1,stringsAsFactors = FALSE,col.names=c("Date","Price"))
#out<- read.table(file.choose(), header=FALSE)
#sqrt(sum((fo$y-out)^2))



#
# Complete the 'calcMissing' function below.
#
# The function accepts STRING_ARRAY readings as parameter.
#

 calcMissing <- function(readings) {
   datess<-c()
   price<-c()
   for (i in 1:length(readings)){
     lines <- unlist(strsplit(readings[i], sp = "\t"))
     datess[i]<-lines[1]
     price[i]<-ifelse(substr(lines[2],1,1)=="M",NA,as.numeric(lines[2]))
   } 
   
   data=data.frame(Price=price,Date=as.POSIXct(datess,format = "%m/%d/%Y %H:%M:%S"))
   
   data$Price=as.numeric(data$Price)
   ts = ts(data$Price)
   y=ts
   inte<-as.vector(na.interp(ts,lambda = "auto"))
   ind<-seq(1,nrow(data),1)
   id.na <- which(is.na(ts))
   #fit=smooth.spline(x=ind[-(id.na)],y=data[-(id.na),2],all.knots = T)
   #fo<-predict(fit,ind[(id.na)])
   
   cat(inte[id.na],sep='\n')
     
 }
# 
# stdin <- file('stdin')
# open(stdin)
# 
readingsCount <- as.integer(trimws(readLines(stdin(), n = 1, warn = FALSE), which = "both"))
readings <- readLines(stdin(), n = readingsCount, warn = FALSE)
# 
# calcMissing(readings)
# 
# close(stdin)
