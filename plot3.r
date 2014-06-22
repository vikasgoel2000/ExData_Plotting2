setwd("C:/Documents and Settings/Imart/My Documents/Downloads/exdata-data-NEI_data")
# Reading Data
NEI <- readRDS("summarySCC_PM25.rds")

# Subsetting for Baltimore
set1<-subset(NEI,NEI$fips=="24510")
library(ggplot2)

#Extracting data required for plotting
dataplot<- aggregate(Emissions ~ year+ type, data = set1, sum, na.rm=TRUE)

#Plotting the Plot
png("plot3.png", height = 300, width = 800)
qplot(year, Emissions, data = dataplot, facets = .~type) +
        scale_x_continuous("Year", breaks = dataplot$year) + 
        labs(title = expression("Total "* PM[2.5]*" Emissions by each Year and Type in Baltimore"))
dev.off()