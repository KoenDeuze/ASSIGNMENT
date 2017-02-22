
library(ggplot2)
# read the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the files
DF <- merge(x = NEI, y = SCC, by = "SCC", all=T)

# create a subset of the coal combustion-related sources
COAL <- DF[grep("Coal", DF$EI.Sector), ]

# create an aggregate (sum on emission) dataframe on sector and year
COAL_SECTOR_AGG <- aggregate(COAL$Emissions, by=list(COAL$EI.Sector, COAL$year), FUN=sum)

# set the columnnames
names(COAL_SECTOR_AGG) <- c("sector","year", "emission")

# create the plot
png("plot_4.png")
options("scipen"=20)
plot <- ggplot(data=COAL_SECTOR_AGG, aes(x=year, y=emission, group=sector, colour=sector) ) 
plot <- plot + geom_line()
plot <- plot + xlab("year") + ylab("emission") + ggtitle("emission per sector per year") 
plot
dev.off()

# alternative for all sectors combined
COAL_AGG <- aggregate(COAL$Emissions, by=list(COAL$year), FUN=sum)

# set the columnnames
names(COAL_AGG) <- c("year", "emission")

# create the plot
png("plot_4_alternative.png")
options("scipen"=20)
plot <- ggplot(data=COAL_AGG, aes(x=year, y=emission) ) 
plot <- plot + geom_line()
plot <- plot + xlab("year") + ylab("emission") + ggtitle("emission per year") 
plot
dev.off()




