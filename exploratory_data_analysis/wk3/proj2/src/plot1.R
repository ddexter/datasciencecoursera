nei <- readRDS('../data/summarySCC_PM25.rds')
#scc <- readRDS('../data/Source_Classification_Code.rds')

df <- aggregate(Emissions~year, nei, sum)

png('../out/plot1.png')
barplot(df$Emissions, main='Total U.S. PM 2.5 Emissions by Year', xlab='Year', ylab='PM 2.5 Emissions (tons)', names.arg=df$year)
dev.off()

