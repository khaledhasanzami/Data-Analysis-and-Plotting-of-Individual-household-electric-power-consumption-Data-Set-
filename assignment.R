#Lets creat a directory to to store the dataset
if (!file.exists("data")) {
    dir.create("data")
}


##Lets download the dataset
#lets assign the data set url to a variable
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
#Lets download the file from the url and save it to directory named "data" .... for windows the method is wininet
download.file(dataset_url, destfile="./data/exdata_data_household_power_consumption.zip", method = "wininet")
#now lets see what we have download
list.files("./data",  all.files=T)
#We would find a zip file. Lets unzip the downloaded zip file
unzip("exdata_data_household_power_consumption.zip")
#lets see what the file was in the zipped file. We will ses a .txt file
list.files("./data",  all.files=T)


##Now lets read the .txt file
power_consumption_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
#lets find out what is it in the dataset
head(power_consumption_data)
tail(power_consumption_data)
#

##Lets subset the dataset
#lets find out what is the class of the Date column
class(power_consumption_data$Date)
#as the date column is in factor class lets convert it in Date class
power_consumption_data$Date <- as.Date(power_consumption_data$Date, format = "%d/%m/%Y")
#now again lets watch the Date column
head(power_consumption_data$Date)
tail(power_consumption_data$Date)
#lets subset according to the condition given
power_consumption_data <- subset(power_consumption_data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#lets watch what we have just subsetted
head(power_consumption_data)
tail(power_consumption_data)


##convertion to the Date/Time class
#Lets combine 2 columns named Date and Time
DateTime<- paste(power_consumption_data$Date, power_consumption_data$Time)
#lets see the combined vector we have just created
head(DateTime)
tail(DateTime)
#Now lets clear the Date and Time column in the data set
power_consumption_data$Date <- power_consumption_data$Time<- NULL
#lets see what happened
head(power_consumption_data)
#now lets bind the vector DateTime to the dataset on the left side
power_consumption_data<- cbind(DateTime, power_consumption_data)
#lets turn the DateTime column in a DateTime Class
power_consumption_data$DateTime <- as.POSIXct(DateTime)
