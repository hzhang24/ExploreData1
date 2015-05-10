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

#plot 1
par(mfrow = c(1,1), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
hist(Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = 2)

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()