#read in data
data <- read.table(unz("exdata_data_household_power_consumption.zip", 
                       "household_power_consumption.txt"), header = TRUE, sep = ";")

#convert Date field class to date class
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#keep only data from 2/1/07 to 2/2/07
subdata <- subset(data, Date %in% as.Date(c("2007-02-01","2007-02-02")))

#combine Date and Time fields
date_time <- paste(subdata$Date, subdata$Time)
date_time <- strptime(date_time, "%Y-%m-%d %H:%M:%S")

#initiate png file
png(file = "plot4.png", width = 480, height = 480)

#fit 4 plots into 1 display
par(mfrow = c(2, 2), mar = c(4, 4, 1, 2), oma = c(1, 2, 1, 0))

#plot Global_Active_Power field against time
gap <- as.numeric(levels(subdata$Global_active_power))[subdata$Global_active_power]
plot(date_time, gap, type = "l", xlab = "", ylab = "Global Active Power")

#plot Voltage field against time
voltage <- as.numeric(levels(subdata$Voltage))[subdata$Voltage]
plot(date_time, voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#convert Sub_metering fields to numeric
sm1 <- as.numeric(levels(subdata$Sub_metering_1))[subdata$Sub_metering_1]
sm2 <- as.numeric(levels(subdata$Sub_metering_2))[subdata$Sub_metering_2]
#plot Sub_metering fields against time
plot(date_time, sm1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(date_time, sm2, type = "l", col = "red")
points(date_time, subdata$Sub_metering_3, type = "l", col = "blue")
#add legends key
legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.75, pt.cex = 1)

#plot Global_reactive_power field against time
grp <- as.numeric(levels(subdata$Global_reactive_power))[subdata$Global_reactive_power]
plot(date_time, grp, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()