library(dplyr)
library(data.table)
#first we read all the data (that must be unzipped in the wd) and select the ones of the dates of our study (EPC) removing the rest
alldata<-fread("household_power_consumption.txt", sep="auto",na.strings="?", stringsAsFactors=FALSE, skip=0, autostart = TRUE)
EPC<-filter(alldata, alldata$Date=="1/2/2007"| alldata$Date=="2/2/2007")
rm(alldata)
#we create a png figure which will contain the plot1
png(file="plot1.png",width=480,height=480)
par(bg=NA)
plot1<-hist(EPC$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency",main="Global Active Power")
dev.off()
