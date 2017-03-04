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
#which contains time and the columns of the y axis of the 4 plots and select the complete cases in plotdata
totdate<-paste(EPC$Date,EPC$Time, sep=" ")
totdate2<-dmy_hms(totdate)
timehms<-hms(EPC$Time)
time<-period_to_seconds(timehms)


plotdata2<-cbind(time,totdate2,EPC$Global_active_power,EPC$Voltage,EPC$Sub_metering_1,EPC$Sub_metering_2,EPC$Sub_metering_3,EPC$Global_reactive_power)
plotdata2<-as.data.frame(plotdata2)
plotdata<-filter(plotdata2, complete.cases(plotdata2))
names(plotdata)<-c("Time","totdate","Global_active_power","voltage", "Sub_metering_1","Sub_metering_2","Sub_metering_3","Global_reactive_power")


#we create a png figure which will contain the plot4
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2),bg=NA)
with(plotdata,{
        plot(totdate2, Global_active_power, type="l", xlab="", ylab = "Global Active Power")
        plot(totdate2, voltage, type="l", xlab="datetime", ylab = "Voltage")
        plot(totdate2, Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering")
        legend("topright",lty=1, col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
        lines(totdate2, plotdata$Sub_metering_1, col="black")
        lines(totdate2, plotdata$Sub_metering_2, col="red")
        lines(totdate2, plotdata$Sub_metering_3, col="blue")
        plot(totdate2, plotdata$Global_reactive_power, type="l", xlab="datetime", ylab = "Global_reactive_power")
        
})
dev.off()

#  in case of incorrect language on the axis, run:
#Sys.putenv(LANGUAGE="en")
#Sys.setenv("LANGUAGE"="En")
