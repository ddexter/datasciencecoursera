library('ggplot2')
library('grid')
library('gridExtra')

nei <- readRDS('../data/summarySCC_PM25.rds')
scc <- readRDS('../data/Source_Classification_Code.rds')

# Select all sectors pertaining to 'coal'.
# Finds 3 unique results
# 1. Fuel Comb - Electric Generation - Coal
# 2. Fuel Comb - Industrial Boilers, ICEs - Coal
# 3. Fuel Comb - Comm/Institutional - Coal
scc_coal <- subset(scc, grepl('coal', EI.Sector, ignore.case=TRUE))
nei_coal <- subset(nei, SCC %in% unique(scc_coal$SCC))

# Total emissions
df <- aggregate(Emissions~year, nei_coal, sum)

# Emissions by coal type
nei_scc <- merge(nei_coal, scc_coal, 'SCC')
df2 <- aggregate(nei_coal$Emissions, list(nei_scc$year, nei_scc$EI.Sector), sum)

png('../out/plot4.png')
# Total emissions by coal
plot1 <- ggplot(data=df, aes(x=sapply(year,as.character), y=Emissions)) +
  geom_bar(stat='identity') +
  xlab('year') +
  ylab('PM 2.5 Emissions (tons)') +
  ggtitle('Total Coal Emissions in U.S.')

# Total emissions by coal type
plot2 <- ggplot(data=df2, aes(x=sapply(Group.1,as.character), y=x)) +
  geom_bar(stat='identity') +
  facet_grid(Group.2 ~ ., scales='free_y') +
  xlab('year') +
  ylab('PM 2.5 Emissions (tons)') +
  ggtitle('Total U.S. PM 2.5 Emissions by Coal Emission Type')

grid.arrange(plot1, plot2, ncol=1, main='U.S. PM 2.5 Emissions from Coal Overview')
dev.off()

