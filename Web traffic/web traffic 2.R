#install.packages("forecast")
library(forecast)

data <- readLines(file("stdin"))
#data <- readLines(file("input.txt"))
d <- as.numeric(data)


startDate <- as.Date("2012-10-01")

t <- ts(as.numeric(d[2:d[1]+1]),start = startDate, frequency = 10)

set.seed(123)
fit <- nnetar(t, decay=0.5, maxit=10)
fcast <- forecast(fit, 30)

writeLines(as.character(round(fcast$mean)))