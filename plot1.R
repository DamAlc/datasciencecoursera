#Load and subset the data
dat<-read.table("household_power_consumption.txt", header=TRUE, sep=";")
dat$DateTime<-strptime(paste(dat$Date, dat$Time, sep = " "),"%d/%m/%Y %H:%M:%S")
data<-subset(dat, dat$Date=="1/2/2007"| dat$Date=="2/2/2007")

#Convert data to numeric
data$Global_active_power<-as.numeric(levels(data$Global_active_power))[data$Global_active_power]

#Creating up the plot
png("plot1.png",width=480,height=480) 
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
