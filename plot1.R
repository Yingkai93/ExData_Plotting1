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

## Create the histogram
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
