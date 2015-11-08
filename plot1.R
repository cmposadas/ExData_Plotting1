#read in data
data <- read.table(unz("exdata_data_household_power_consumption.zip", 
                       "household_power_consumption.txt"), header = TRUE, sep = ";")

#convert Date field class to date class
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#keep only data from 2/1/07 to 2/2/07
subdata <- subset(data, Date %in% as.Date(c("2007-02-01","2007-02-02")))

#convert Global_active_power field to numeric class
gap <- as.numeric(levels(subdata$Global_active_power))[subdata$Global_active_power]

#plot histogram for converted Global_active_power field
par(oma = c(1, 2, 1, 0), mar = c(4, 4, 2, 2)) #establish margins
hist(gap, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#save plot to png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()