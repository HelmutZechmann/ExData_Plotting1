library(sqldf)
library(lubridate)

# read the raw data, we expect the input file in a subfolder named "data"
d <- read.csv.sql("data//household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";") 

# convert date and time strings to datetime object
d$DateTime <- dmy_hms(paste(d$Date, d$Time))

# convert date and time strings to datetime object
library(lubridate)
d$DateTime <- dmy_hms(paste(d$Date, d$Time))

# open png output
png(filename = "plot1.png", width = 504, height = 504, units ="px")

# plot histogram
hist(
    x = d$Global_active_power, 
    col = "red", 
    xlab = "Global Active Power (kilowatts)",
    main = "Global Active Power"
)

# save data
dev.off()