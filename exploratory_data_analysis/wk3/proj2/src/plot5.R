library('ggplot2')

nei <- readRDS('../data/summarySCC_PM25.rds')
scc <- readRDS('../data/Source_Classification_Code.rds')

# Select all sectors pertaining to 'mobile' since "motor vehicle" is an ambiguous term
scc_mobile <- subset(scc, grepl('mobile', EI.Sector, ignore.case=TRUE))
nei_mobile <- subset(nei, SCC %in% unique(scc_mobile$SCC))

# Total emissions for Baltimore City, MD
df <- subset(nei_mobile, fips == '24510')
df <- aggregate(Emissions~year, df, sum)

png('../out/plot5.png')
# Total emissions by mobile
ggplot(data=df, aes(x=sapply(year,as.character), y=Emissions)) +
  geom_bar(stat='identity') +
  xlab('year') +
  ylab('PM 2.5 Emissions (tons)') +
  ggtitle('Baltimore, MD Motor Vehicle Emissions in U.S.')
dev.off()

