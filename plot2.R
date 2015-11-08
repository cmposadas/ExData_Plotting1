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

#plot Global_Active_Power field against time
par(oma = c(1, 2, 1, 0), mar = c(4, 4, 2, 2)) #establish margins
gap <- as.numeric(levels(subdata$Global_active_power))[subdata$Global_active_power]
plot(date_time, gap, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#save plot to PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()