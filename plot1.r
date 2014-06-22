setwd("C:/Documents and Settings/Imart/My Documents/Downloads/exdata-data-NEI_data")
# Reading Data
NEI <- readRDS("summarySCC_PM25.rds")
NEI$year<-as.factor(NEI$year)

#Getting the values year wise using tapply to being more memory efficient. 
a<-tapply(NEI$Emissions,NEI$year,FUN=sum)
a<-data.frame(a)
colnames(a)[1]<-"Emissions"
a$year<-rownames(a)
rownames(a)<-NULL

#Plotting the Plot
png("plot1.png", height = 600, width = 480)
barplot((a$Emissions/1000000),names.arg = c("1999","2002","2005","2008"), 
        col = "steelblue",xlab = "Years",
        ylab = expression("Total "* PM[2.5]*" Emissions in Mega-Tons"),
        main = expression("Emissions of  "* PM[2.5]*" by each year(all sources)"))
dev.off()