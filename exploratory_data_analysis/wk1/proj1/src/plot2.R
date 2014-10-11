START_DATE <- as.Date("2007-02-01")
END_DATE <- as.Date("2007-02-02")
FILE_PATH <- '../data/household_power_consumption.txt'

df <- read.csv(FILE_PATH, header=T, sep=";", na.strings=c("?"))
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- subset(df, Date == START_DATE | Date == END_DATE)
df$DateTime <- strptime(paste(df$Date, df$Time, sep=' '), '%Y-%m-%d %H:%M:%S')
df <- subset(df, !is.na(Global_active_power))

png('../out/plot2.png', width=480, height=480)
plot(df$DateTime, df$Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab='')
dev.off()

