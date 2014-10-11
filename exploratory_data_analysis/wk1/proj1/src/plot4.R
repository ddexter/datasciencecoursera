START_DATE <- as.Date("2007-02-01")
END_DATE <- as.Date("2007-02-02")
FILE_PATH <- '../data/household_power_consumption.txt'

df <- read.csv(FILE_PATH, header=T, sep=";", na.strings=c("?"))
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- subset(df, Date == START_DATE | Date == END_DATE)
df$DateTime <- strptime(paste(df$Date, df$Time, sep=' '), '%Y-%m-%d %H:%M:%S')

png('../out/plot4.png', width=480, height=480)
par(mfrow=c(2,2))

# Plot 1
df_tmp <- subset(df, !is.na(Global_active_power))
plot(df_tmp$DateTime, df_tmp$Global_active_power, type='l', ylab='Global Active Power', xlab='')

# Plot 2
df_tmp <- subset(df, !is.na(Voltage))
plot(df_tmp$DateTime, df_tmp$Voltage, type='l', ylab='Voltage', xlab='datetime')

# Plot 3
df_tmp <- subset(df, !is.na(Sub_metering_1))
plot(df_tmp$DateTime, df_tmp$Sub_metering_1, type='l', ylab='Energy sub metering', xlab='')

df_tmp <- subset(df, !is.na(Sub_metering_2))
lines(df_tmp$DateTime, df_tmp$Sub_metering_2, type='l', col='red')

df_tmp <- subset(df, !is.na(Sub_metering_3))
lines(df_tmp$DateTime, df_tmp$Sub_metering_3, type='l', col='blue')

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty=c(1,1,1), col=c('black', 'red', 'blue'), bty='n')

# Plot 4
df_tmp <- subset(df, !is.na(Global_reactive_power))
plot(df_tmp$DateTime, df_tmp$Global_reactive_power, type='l', ylab='Global_reactive_power', xlab='datetime')

dev.off()

