library(sqldf)
library(lubridate)


# read the raw data, we expect the input file in a subfolder named "data"
d <- read.csv.sql("data//household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";") 

# convert date and time strings to datetime object
d$DateTime <- dmy_hms(paste(d$Date, d$Time))

# open png output
png(filename = "plot4.png", width = 504, height = 504, units ="px", bg = "transparent")


# init plot with four subplots
par(mfrow = c(2, 2))

with(d, {
    
    # plot 1
    plot(Global_active_power ~ DateTime, type = "l", xlab =  "", ylab = "Global Active Power")
    
    # plot 2
    plot(Voltage ~ DateTime, type = "l", xlab =  "datetime")
    
    # plot 3
    plot(
        Sub_metering_1 ~ DateTime,
        type = "n", 
        ylab = "Energy sub metering",
        xlab = ""
    )
        
    lines(Sub_metering_1 ~ DateTime, col = "black")
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
        
    legend(
        "topright", 
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
        lty=c(1, 1, 1), 
        col=c("black","red", "blue"),
        bty = "n"
    )
    
    # plot 4
    plot(Global_reactive_power ~ DateTime, type = "l", xlab = "datetime")
})

# save png
dev.off()
