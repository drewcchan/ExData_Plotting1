#Loading relevant packages
library(data.table)
library(dplyr)
library(lubridate)

#Downloading dataset
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
unzip("data.zip", exdir="data")
files<-list.files("data",full.names=TRUE)
#Reading in database
database<-fread(files[1], na.strings="?")
#Subsetting for relevant data and creating a new Datetime variable
datasubset<-filter(database,Date=="1/2/2007"|Date=="2/2/2007")%>%
        mutate(Datetime=dmy_hms(paste(Date,Time)))

#Creating plot 4 as a png file
png(file="plot4.png",width=480, height=480)
#Splits into 2x2 area
par(mfrow=c(2,2))
#Top-left plot
plot(x=datasubset$Datetime, y=as.numeric(datasubset$Global_active_power), type="l",xlab="", ylab="Global Active Power")
#Top-right plot
plot(x=datasubset$Datetime, y=as.numeric(datasubset$Voltage), type="l",xlab="datetime", ylab="Voltage")
#Bottom-left plot
plot(x=datasubset$Datetime,y=as.numeric(datasubset$Sub_metering_1), type="l",
     ylab="Energy sub metering", xlab="")
lines(x=datasubset$Datetime,y=as.numeric(datasubset$Sub_metering_2),col='Red')
lines(x=datasubset$Datetime,y=as.numeric(datasubset$Sub_metering_3),col='Blue')
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=1,lwd=2,bty="n")
#Bottom-right plot
plot(x=datasubset$Datetime, y=as.numeric(datasubset$Global_reactive_power), type="l",xlab="datetime", ylab="Global_reactive_power")
#Closing png graphic device
dev.off()