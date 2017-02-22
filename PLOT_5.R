library(ggplot2)
# read the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# join the files
DF <- merge(x = NEI, y = SCC, by = "SCC", all=T)

# create a subset of Baltimore
BALT <- subset(DF, fips=="24510")

# create a subset of the vehicle sources in Baltimore
BALT_VEHICLES <- BALT[grep("Vehicles", BALT$EI.Sector), ]

# create an aggregate (sum on emission) dataframe on sector and year
BALT_VEHICLES_AGG <- aggregate(BALT_VEHICLES$Emissions, by=list(BALT_VEHICLES$EI.Sector, BALT_VEHICLES$year), FUN=sum)


# set the columnnames
names(BALT_VEHICLES_AGG) <- c("sector","year", "emission")

# create the plot
png("plot_5.png")
options("scipen"=20)
plot <- ggplot(data=BALT_VEHICLES_AGG, aes(x=year, y=emission, group=sector, colour=sector) ) 
plot <- plot + geom_line()
plot <- plot + xlab("year") + ylab("emission") + ggtitle("emission per sector per year") 
plot
dev.off()

# alternative for all sectors combined

# create an aggregate (sum on emission) dataframe on year
BALT_VEHICLES_AGG <- aggregate(BALT_VEHICLES$Emissions, by=list(BALT_VEHICLES$year), FUN=sum)


# set the columnnames
names(BALT_VEHICLES_AGG) <- c("year", "emission")

# create the plot
png("plot_5_alternative.png")
options("scipen"=20)
plot <- ggplot(data=BALT_VEHICLES_AGG, aes(x=year, y=emission) ) 
plot <- plot + geom_line()
plot <- plot + xlab("year") + ylab("emission") + ggtitle("emission per year") 
plot
dev.off()




