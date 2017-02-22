library(ggplot2)
# read the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the files
DF <- merge(x = NEI, y = SCC, by = "SCC", all=T)

# create a subset of the vehicle sources
VEHICLES <- DF[grep("Vehicles", DF$EI.Sector), ]

# create a subset of the vehicles in Baltimore and California
VEH_BALT_CALIF <- subset(VEHICLES, fips %in% c("24510","06037") )

# create an aggregate (sum on emission) dataframe on fips and year
AGG <- aggregate(VEH_BALT_CALIF$Emissions, by=list(VEH_BALT_CALIF$fips, VEH_BALT_CALIF$year), FUN=sum, na.rm=TRUE, na.action=NULL)



# set the columnnames
names(AGG) <- c("fips","year", "emission")

# replace the fips number with the county name
counties <- data.frame(fips=c("06037","24510"),name=c("California","Baltimore City"))
AGG[["fips"]] <- counties[ match(AGG[['fips']], counties[['fips']] ) , 'name']
names(AGG) <- c("county","year", "emission")

# create the plot
png("plot_6.png")
options("scipen"=20)
plot <- ggplot(data=AGG, aes(x=year, y=emission, group=county, colour=county) ) 
plot <- plot + geom_line()
plot <- plot + xlab("year") + ylab("emission") + ggtitle("emission per county per year") 
plot
dev.off()