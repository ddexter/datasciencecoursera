START_DATE <- as.Date("2007-02-01")
END_DATE <- as.Date("2007-02-02")
FILE_PATH <- '../data/household_power_consumption.txt'

df <- read.csv(FILE_PATH, header=T, sep=";", na.strings=c("?"))
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- subset(df, Date == START_DATE | Date == END_DATE)

png('../out/plot1.png', width=480, height=480)
hist(na.omit(df$Global_active_power), xlab='Global Active Power (kilowatts)', ylab='Frequency', main='Global Active Power', col='red')
dev.off()

