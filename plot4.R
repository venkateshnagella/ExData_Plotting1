#Reading the data
data <- read.table("household_power_consumption.txt", 
                   sep = ";", 
                   skip=66636, 
                   nrows = 2880, 
                   na.strings = "?", 
                   header = T)

#Naming the columns
names(data) <- c("Date", 
                 "Time",
                 "Global_active_power",
                 "Global_reactive_power",
                 "Voltage",
                 "Global_intensity",
                 "Sub_metering_1",
                 "Sub_metering_2",
                 "Sub_metering_3")

#Creating datetime variable by joining date and time columns
datetime <- paste(data$Date, data$Time)

#changing type of datetime to POSIX format
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")

#Appending datetime to dataframe
data <- data.frame(datetime, data)

#creating the plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
with(data, {
        plot(datetime, Global_active_power, type="l", xlab="", ylab = "Global Active Power")
        plot(datetime, Voltage, type="l", xlab="datetime", ylab = "Voltage")
        plot (datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
        lines (datetime, Sub_metering_2, type = "l", col = "red")
        points (datetime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), box.col="white")
        plot(datetime, Global_reactive_power, type="l", xlab="datetime", ylab = "Global_reactive_power")
        
})

dev.off()
