nei <- readRDS('../data/summarySCC_PM25.rds')
#scc <- readRDS('../data/Source_Classification_Code.rds')

df <- aggregate(Emissions~year, subset(nei, fips == '24510'), sum)

png('../out/plot2.png')
barplot(df$Emissions, main='Baltimore City, MD PM 2.5 Emissions by Year', xlab='Year', ylab='PM 2.5 Emissions (tons)', names.arg=df$year)
dev.off()

