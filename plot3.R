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

# plot 3
with(mysubdata, plot(DateTime, Sub_metering_1, 
                     xlab = "", ylab = "Energy sub metering", type = "l", col = 1, ylim =c(0, 40)))
with(mysubdata, points(DateTime, Sub_metering_2, 
                       xlab = "", ylab = "Energy sub metering", type = "l", col = 2, ylim =c(0, 40)))
with(mysubdata, points(DateTime, Sub_metering_3, 
                       xlab = "", ylab = "Energy sub metering", type = "l", col = 4, ylim =c(0, 40)))
legend("topright", col = c(1, 2, 4), lwd = 2, lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()