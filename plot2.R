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
png("plot2.png", width=480, height=480)

plot(data$datetime, data$Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)")

dev.off()
