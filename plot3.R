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

#Creating plot 3 as a png file
png(file="plot3.png",width=480, height=480)
#Creates plotting area for Sub_metering_1 vs datetime
plot(x=datasubset$Datetime,y=as.numeric(datasubset$Sub_metering_1), type="l",
             ylab="Energy sub metering", xlab="")
#Adds line for Sub_metering_2 vs datetime
lines(x=datasubset$Datetime,y=as.numeric(datasubset$Sub_metering_2),col='Red')
#Adds line for Sub_metering_3 vs datetime
lines(x=datasubset$Datetime,y=as.numeric(datasubset$Sub_metering_3),col='Blue')
#Adds legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=1,lwd=2)
#Closing png graphic device
dev.off()