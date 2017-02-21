# read the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create a subset
NEI_BALT <- subset(NEI, fips=="24510")

# create an aggregate
NEI_BALT_AGG <- aggregate(NEI_BALT$Emissions, by=list(year=NEI_BALT$year), FUN=sum)

# create the plot
png("plot_2.png")
options("scipen"=20)
plot(NEI_BALT_AGG, xlab="year", ylab="emission", col='red', main = "Total Emissions PM2.5 Baltimore City")
lines(NEI_BALT_AGG, col='red')
dev.off()