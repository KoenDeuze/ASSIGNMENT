# read the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create an aggregate
NEI_AGG <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)

# create the plot
png("plot_1.png")
options("scipen"=20)
plot(NEI_AGG, xlab="year", ylab="emission", col='red', main = "Total Emissions PM2.5 United States")
lines(NEI_AGG, col='red')
dev.off()