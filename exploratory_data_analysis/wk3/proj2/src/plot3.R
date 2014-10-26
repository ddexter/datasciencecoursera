library('ggplot2')

nei <- readRDS('../data/summarySCC_PM25.rds')

df <- subset(nei, fips == '24510')
df <- aggregate(df$Emissions, list(df$year,df$type), sum)

png('../out/plot3.png')
ggplot(data=df, aes(x=sapply(Group.1,as.character), y=x)) +
  geom_bar(stat='identity') +
  facet_grid(Group.2 ~ ., scales='free_y') +
  xlab('year') +
  ylab('PM 2.5 Emissions (tons)') +
  ggtitle('Baltimore City, MD PM 2.5 Emissions by Measurement Type')
dev.off()

