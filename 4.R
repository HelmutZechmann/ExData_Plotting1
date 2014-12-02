# read the raw data, we expect the input file in a subfolder named "data"
d <- read.table(
    "data/household_power_consumption.txt", 
    header = TRUE, 
    sep = ";",
    na.strings = "?"
)

# convert date and time strings to datetime object
library(lubridate)
d$DateTime <- dmy_hms(paste(d$Date, d$Time))

# select the relevant two days
subset <- d[as.Date(d$DateTime) %in% c(as.Date("2007/02/01"), as.Date("2007/02/02")), ]

# open png output
png(filename = "plot4.png", width = 504, height = 504, units ="px")


# init plot with four subplots
par(mfrow = c(2, 2))

with(subset, {
    
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
