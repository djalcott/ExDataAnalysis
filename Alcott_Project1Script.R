#Set Working directory
setwd("~/Coursera")
#read in data
ALLdata <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
head(ALLdata)
#subset data by each of 2 days used
feb1data<-subset(ALLdata, Date=='1/2/2007')
feb2data<-subset(ALLdata,Date=='2/2/2007')
#combine 2 subsets to create data set to be used for Project 1
data<-rbind(feb1data, feb2data)
#head(data)
#tail(data)

#convert character to DateTime
data$DateTime <- paste(data$Date, data$Time, sep=" ")
data$datetime <- as.POSIXct(strptime(data$DateTime, "%d/%m/%Y %H:%M:%S"))


png('GlobalActivePowerHist.png')
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red",main="Global Active Power")
dev.off()


png('GlobalPowerTimeLine.png')
plot(data$datetime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)") 
dev.off()

png('LocalPowerTimeLines.png')
plot(data$datetime, data$Sub_metering_1, ylab="Energy sub metering", type="l",col="grey", xlab="")
  lines(data$datetime, data$Sub_metering_2, col="red")
  lines(data$datetime, data$Sub_metering_3, col="blue")
  legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()


#multiple plots
png('AllPlots.png')
par(mfrow=c(2,2))
  plot(data$datetime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="") 
  plot(data$datetime, data$Voltage, type="l", ylab="Voltage", xlab="datetime") 
  plot(data$datetime, data$Sub_metering_1, ylab="Energy sub metering", type="l",col="grey", xlab="")
    lines(data$datetime, data$Sub_metering_2, col="red")
    lines(data$datetime, data$Sub_metering_3, col="blue")
    legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
plot(data$datetime, data$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime") 
dev.off()
