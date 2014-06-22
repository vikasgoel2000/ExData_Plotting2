setwd("C:/Documents and Settings/Imart/My Documents/Downloads/exdata-data-NEI_data")
#Reading Data
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year<-as.factor(NEI$year)
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting data for Baltimore
set1<-subset(NEI,NEI$fips=="24510")
motor <- SCC[grepl("Vehicle",SCC$EI.Sector),]$SCC
total_motor <- subset(set1, set1$SCC %in% motor)

#Getting the values year wise using tapply to being more memory efficient. 
d<-tapply(total_motor$Emissions,total_motor$year,FUN=sum)
d<-data.frame(d)
colnames(d)[1]<-"Emissions"
d$year<-rownames(d)
rownames(d)<-NULL

#Subsetting data for Los Angeles
set2<-subset(NEI,NEI$fips=="06037")
motor1 <- SCC[grepl("Vehicle",SCC$EI.Sector),]$SCC
total_motor1 <- subset(set2, set2$SCC %in% motor1)
e<-tapply(total_motor1$Emissions,total_motor1$year,FUN=sum)
e<-data.frame(e)
colnames(e)[1]<-"Emissions"
e$year<-rownames(e)
rownames(e)<-NULL

# Plotting the Plot
png("plot6.png", height = 800, width = 480)
par(mfrow = c(2,1))
barplot(d$Emissions, names.arg = c("1999","2002","2005","2008"), 
                  col = "steelblue",xlab = "Years",ylab = expression("Total "* PM[2.5]*" Emissions tons"),
                  main = expression("Emissions of  "* PM[2.5]*" by each year from motor vehicle in Baltimore"))
barplot(e$Emissions, names.arg = c("1999","2002","2005","2008"), 
                  col = "steelblue",xlab = "Years",ylab = expression("Total "* PM[2.5]*" Emissions tons"),
                  main = expression("Emissions of  "* PM[2.5]*" by each year from motor vehicle Los Angeles"))
dev.off()