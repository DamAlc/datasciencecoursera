#Load and subset the data
dat<-read.table("household_power_consumption.txt", header=TRUE, sep=";")
dat$DateTime<-strptime(paste(dat$Date, dat$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
data<-subset(dat, dat$Date=="1/2/2007"| dat$Date=="2/2/2007")

#Convert data to numeric
data$Sub_metering_1<-as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
data$Sub_metering_2<-as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]
data$Sub_metering_3<-as.numeric(levels(data$Sub_metering_3))[data$Sub_metering_3]
data$Global_active_power<-as.numeric(levels(data$Global_active_power))[data$Global_active_power]
data$Voltage<-as.numeric(levels(data$Voltage))[data$Voltage]
data$Global_reactive_power<-as.numeric(levels(data$Global_reactive_power))[data$Global_reactive_power]

#Creating up the plot
png("plot4.png",width=480,height=480)    
par(mfrow=c(2,2), cex=0.6, mar = c(4, 4, 3, 2), oma = c(1, 1, 0, 0))
    with(data, {
      plot(DateTime,Global_active_power, type="l",xlab="",ylab="Global Active Power")
      plot(DateTime,Voltage, type="l",xlab="datatime",ylab="Voltage")
      plot(DateTime,Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
      lines(DateTime,Sub_metering_2, type="l", col="red")
      lines(DateTime,Sub_metering_3, type="l", col="blue")
      legend("topright", lty=c(1,1,1), bty="n", col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
      plot(DateTime,Global_reactive_power, type="l",xlab="datatime")
    })
dev.off()
