install.packages("ggplot2")
install.packages("gridExtra")
library("ggplot2")
library("grid")
library("gridExtra")

# read the 2 files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# create an aggregate (sum on emission) dataframe on type and year
NEI_AGG_TYPE <- aggregate(NEI$Emissions, by=list(NEI$type, NEI$year), FUN=sum)

# set the columnnames
names(NEI_AGG_TYPE) <- c("type","year", "emission")

# create the plot
png("plot_3.png")
options("scipen"=20)
plot <- ggplot(data=NEI_AGG_TYPE, aes(x=year, y=emission, group=type, colour=type) ) 
plot <- plot + geom_line()
plot <- plot + xlab("year") + ylab("emission") + ggtitle("emission per type per year") 
plot
dev.off()

# alternative, just some testing en trying.... :) 
source("http://peterhaschke.com/Code/multiplot.R")

# create 4 subsets per type
NEI_POINT <- subset(NEI_AGG_TYPE, type =="POINT")
names(NEI_POINT) <- c("type","year", "emission")
NEI_NONPOINT <- subset(NEI_AGG_TYPE, type =="NONPOINT")
names(NEI_NONPOINT) <- c("type","year", "emission")
NEI_ONROAD <- subset(NEI_AGG_TYPE, type =="ON-ROAD")
names(NEI_ONROAD) <- c("type","year", "emission")
NEI_NONROAD <- subset(NEI_AGG_TYPE, type =="NON-ROAD")
names(NEI_NONROAD) <- c("type","year", "emission")

p1 <- ggplot(NEI_POINT, aes(x=year, y=emission, colour=type, group=type)) +  geom_line() +  ggtitle("Emission POINT")
p2 <- ggplot(NEI_NONPOINT, aes(x=year, y=emission, colour=type, group=type)) +  geom_line() +  ggtitle("Emission NON-POINT")
p3 <-ggplot(NEI_ONROAD, aes(x=year, y=emission, colour=type, group=type)) +  geom_line() +  ggtitle("Emission ON-ROAD")
p4 <-ggplot(NEI_NONROAD, aes(x=year, y=emission, colour=type, group=type)) +  geom_line() +  ggtitle("Emission NON-ROAD")

png(filename = "PLOT_ALTERNATIVE_3.PNG")
multiplot(p1,p2,p3,p4,cols=1)
dev.off()


