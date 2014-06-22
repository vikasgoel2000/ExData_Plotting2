setwd("C:/Documents and Settings/Imart/My Documents/Downloads/exdata-data-NEI_data")
# Reading the Data
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year<-as.factor(NEI$year)
SCC <- readRDS("Source_Classification_Code.rds")

# Extracting data for Coal combustion related sources
coal <- SCC[grepl("Coal",SCC$EI.Sector),]$SCC
total_coal <- subset(NEI, NEI$SCC %in% coal)

# Extracting data for plotting purpose
c<-tapply(total_coal$Emissions,total_coal$year,FUN=sum)
c<-data.frame(c)
colnames(c)[1]<-"Emissions"
c$year<-rownames(c)
rownames(c)<-NULL

#Plotting the Plot
png("plot4.png", height = 300, width = 800)
barplot((c$Emissions/1000), names.arg = c("1999","2002","2005","2008"), 
            col = "steelblue",xlab = "Years",ylab = expression("Total "* PM[2.5]*" Emissions in Kilo-tons"),
            main = expression("Emissions of  "* PM[2.5]*" by each year for Coal Combustion related Sources"))
dev.off()