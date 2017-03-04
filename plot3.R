plot.new
library(dplyr)
library(data.table)
library(lubridate)
library(graphics)
library(grDevices)
#first we read all the data (that must be unzipped in the wd) and select the ones of the dates of our study (EPC) removing the rest
alldata<-fread("household_power_consumption.txt", sep="auto",na.strings="?", stringsAsFactors=FALSE, skip=0, autostart = TRUE)
EPC<-filter(alldata, alldata$Date=="1/2/2007"| alldata$Date=="2/2/2007")
rm(alldata)

#we create totdate2, which will contain the time and hour, time which contain time in seconds, plotdata2
#which contains time and the column of the y axis of the plot and select the complete cases in plotdata
totdate<-paste(EPC$Date,EPC$Time, sep=" ")
totdate2<-dmy_hms(totdate)
timehms<-hms(EPC$Time)
time<-period_to_seconds(timehms)
plotdata2<-cbind(time,EPC$Sub_metering_1,EPC$Sub_metering_2,EPC$Sub_metering_3)
plotdata2<-as.data.frame(plotdata2)
plotdata<-filter(plotdata2, complete.cases(plotdata2))
names(plotdata)<-c("Time","Sub_metering_1","Sub_metering_2","Sub_metering_3")


#we create a png figure which will contain the plot3
png(file="plot3.png",width=480,height=480)
par(bg=NA)
plot(totdate2, plotdata$Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering")
lines(totdate2, plotdata$Sub_metering_1, col="black")
lines(totdate2, plotdata$Sub_metering_2, col="red")
lines(totdate2, plotdata$Sub_metering_3, col="blue")
legend("topright", lty=1,col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

#  in case of incorrect language on the axis, run:
#Sys.putenv(LANGUAGE="en")
#Sys.setenv("LANGUAGE"="En")