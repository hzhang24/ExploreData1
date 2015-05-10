# download the zipped file and place it in the current directory
# read the dataset into R
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                     colClasses = c("character", "character", rep("numeric", 7)), na = "?")
# use dplyr to tidy the tidy, only include 07/2/1 and 07/2/2's data
library(dplyr)
mydata3 <- tbl_df(mydata)
head(mydata3)
str(mydata3)
mysubdata <- filter(mydata3, Date == "1/2/2007" | Date == "2/2/2007")
dim(mysubdata)
# add additional column 'DateTime'using strptime function
attach(mysubdata)
dt <- paste(Date, Time)
mysubdata$DateTime <- strptime(dt, "%d/%m/%Y %H:%M:%S")
str(mysubdata) # 2880 10

# plot 4
# 4-1
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(mysubdata, 
     plot(DateTime, Global_active_power, 
          xlab = "", ylab = "Global Active Power", type = "l"))
# 4-2
with(mysubdata, 
     plot(DateTime, Voltage, 
          xlab = "datetime", ylab = "Voltage", type = "l"))
# 4-3
with(mysubdata, plot(DateTime, Sub_metering_1, xlab = "", 
                     ylab = "Energy sub metering", type = "l", col = 1, ylim =c(0, 40)))
with(mysubdata, points(DateTime, Sub_metering_2, xlab = "", 
                       ylab = "Energy sub metering", type = "l", col = 2, ylim =c(0, 40)))
with(mysubdata, points(DateTime, Sub_metering_3, xlab = "", 
                       ylab = "Energy sub metering", type = "l", col = 4, ylim =c(0, 40)))
legend("topright", col = c(1, 2, 4), lwd = 1, lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
# 4-4
with(mysubdata, 
     plot(DateTime, Global_reactive_power, 
          xlab = "datetime", ylab = "Global_reactive_power", type = "l", ylim= c(0, 0.5)))

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
