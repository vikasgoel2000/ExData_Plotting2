setwd("C:/Documents and Settings/Imart/My Documents/Downloads/exdata-data-NEI_data")
#Reading the Data
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year<-as.factor(NEI$year)
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data for baltimore with vehicle souce of emission
set1<-subset(NEI,NEI$fips=="24510")
motor <- SCC[grepl("Vehicle",SCC$EI.Sector),]$SCC

total_motor <- subset(set1, set1$SCC %in% motor)
d<-tapply(total_motor$Emissions,total_motor$year,FUN=sum)
d<-data.frame(d)
colnames(d)[1]<-"Emissions"
d$year<-rownames(d)
rownames(d)<-NULL

# Plotting the Plot
png("plot5.png", height = 400, width = 800)
barplot(d$Emissions, names.arg = c("1999","2002","2005","2008"), 
          col = "steelblue",xlab = "Years",ylab = expression("Total "* PM[2.5]*" Emissions tons"),
          main = expression("Emissions of  "* PM[2.5]*" by each year from motor vehicle Sources in Baltimore"))
dev.off()
