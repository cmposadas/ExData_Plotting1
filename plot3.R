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

#convert Sub_metering fields to numeric
sm1 <- as.numeric(levels(subdata$Sub_metering_1))[subdata$Sub_metering_1]
sm2 <- as.numeric(levels(subdata$Sub_metering_2))[subdata$Sub_metering_2]

#plot Sub_metering fields against time
png(file = "plot3.png", width = 480, height = 480) #save plot to PNG file
par(oma = c(1, 2, 1, 0), mar = c(4, 4, 2, 2)) #establish margins
plot(date_time, sm1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(date_time, sm2, type = "l", col = "red")
points(date_time, subdata$Sub_metering_3, type = "l", col = "blue")

#add legends key
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()