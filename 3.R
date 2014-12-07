library(sqldf)
library(lubridate)


# read the raw data, we expect the input file in a subfolder named "data"
d <- read.csv.sql("data//household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", header = TRUE, sep = ";") 

# convert date and time strings to datetime object
d$DateTime <- dmy_hms(paste(d$Date, d$Time))


# open png output
png(filename = "plot3.png", width = 504, height = 504, units ="px", bg = "transparent")

with(d, {
    # initialize plot
    plot(
        Sub_metering_1 ~ DateTime,
        type = "n", 
        ylab = "Energy sub metering",
        xlab = ""
    )

    # add lines

    lines(Sub_metering_1 ~ DateTime, col = "black")
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
})

# add legend
legend(
    "topright", 
    c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
    lty=c(1, 1, 1), 
    col=c("black","red", "blue")
)

# save png
dev.off()