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

#Creating plot 2 as a png file
png(file="plot2.png",width=480, height=480)
plot(x=datasubset$Datetime, y=as.numeric(datasubset$Global_active_power), type="l",xlab="", ylab="Global Active Power (kilowatts)")
#Closing png graphic device
dev.off()