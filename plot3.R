rm(list = ls()) ## Clean up the workplace
library(lubridate)

## Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric','numeric',
                                  'numeric','numeric','numeric'))

## Format date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
data <- data[complete.cases(data), ]

## Combine Date and Time column
DateTime <- paste(data$Date, data$Time)

## Name the vector
DateTime <- setNames(DateTime, "DateTime")

## Remove Date and Time column
data <- data[ ,!(names(data) %in% c("Date","Time"))]

## Add DateTime column
data <- cbind(DateTime, data)

## Format DateTime Column
data$DateTime <- as.POSIXct(DateTime)

## Create Plot 3
with(data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
