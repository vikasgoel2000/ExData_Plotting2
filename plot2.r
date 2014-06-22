setwd("C:/Documents and Settings/Imart/My Documents/Downloads/exdata-data-NEI_data")
#Reading the Data
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year<-as.factor(NEI$year)

#Subsetting for Baltimore
set1<-subset(NEI,NEI$fips=="24510")

#Getting the values year wise using tapply to being more memory efficient. 
b<-tapply(set1$Emissions,set1$year,FUN=sum)
colnames(b)[1]<-"Emissions"
a$year<-rownames(b)
rownames(b)<-NULL

#Plotting the Plot
png("plot2.png", height = 600, width = 480)
barplot((b$Emissions),names.arg = c("1999","2002","2005","2008"), 
        col = "steelblue",xlab = "Years",
        ylab = expression("Total "* PM[2.5]*" Emissions in Mega-Tons"),
        main = expression("Emissions of  "* PM[2.5]*" by each year(all sources)"))
dev.off()