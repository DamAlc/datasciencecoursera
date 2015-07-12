#Load and subset the data
dat<-read.table("household_power_consumption.txt", header=TRUE, sep=";")
dat$DateTime<-strptime(paste(dat$Date, dat$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
data<-subset(dat, dat$Date=="1/2/2007"| dat$Date=="2/2/2007")

#Convert data to numeric
data$Sub_metering_1<-as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
data$Sub_metering_2<-as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]
data$Sub_metering_3<-as.numeric(levels(data$Sub_metering_3))[data$Sub_metering_3]

#Creating up the plot
png("plot3.png",width=480,height=480) 
plot(data$DateTime,data$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
lines(data$DateTime,data$Sub_metering_2, type="l", col="red")
lines(data$DateTime,data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
