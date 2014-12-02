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
png(filename = "plot1.png", width = 504, height = 504, units ="px")

# plot histogram
hist(
    x = subset$Global_active_power, 
    col = "red", 
    xlab = "Global Active Power (kilowatts)",
    main = "Global Active Power"
)

# save data
dev.off()