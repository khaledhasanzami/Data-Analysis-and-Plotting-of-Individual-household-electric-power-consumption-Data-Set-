
# **Data Analysis and Plotting of "Individual household electric power consumption Data Set"**
Our main goal with the question is given on the link here: https://github.com/rdpeng/ExData_Plotting1

We will be analysing the dataset and making desired plotts from the dataset.

We will be explaining the process step by step from scratch and with the prbable problems to be faced along with a solution and explanation. Let's get started.

## **Step 01: Load the desired data.**
First of all, lets set the working directory to wokrk in. We can do it using the `setwd()` and giving the path in the command. But i prefer to set the directory graphically. For this click on the *Session* on the top left corner, you will find *Set Working Directory* then click on *Choose Working Directory*. Then, set the directory you want to work on. In that, lets create a separate directory named *data* and we will be downloading and saving all the files in it. 
```
if (!file.exists("data")) {
    dir.create("data")
}
```
What it does the 1st line checks if there is any directory named *data* in the working directory. If not then the 2nd line creates a directory named *data*. 

Now, we are going to download the dataset from the website. For our usefullness, an url containing the zip file of the dataset is given in the question. Lets download from the url.
```
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
```
First, we copy and paste the url of the dataset in a variable to be called again for download.
Then, we are going to download the file calling the variable where we saved the url.
```
download.file(dataset_url)
```
But it will download the file in the working directory. Instead, we want the file in my desired directory which we created naming *data*. Now, what to do? If we search for `download.file()` in google and look for it in the *rdocumentation*, we will see there is an argument named *destfile* where we can define the path where we want to download the file. So, i set the srgument `destfile` to my desired directory to download. 
```
download.file(dataset_url, destfile="./data/exdata_data_household_power_consumption.zip")
```
Here, we used **"."** and a **"/"** asfter the dot. Here, **"." (dot)** signifies the current directory. So, it will only look for directory named **"data"** only in the current working directory instead of looking the whole computer. In the  **"data"** directory, we specified the file name as  **"exdata_data_household_power_consumption.zip"**. So, it will be downloaded in the following name.

But, the url is **https**. So, it's secured and we need to specify a method using the **method** argument. If the method is not set, we may end up with unsupported files. We are describing two separate methods while downloading one is for windows and other is mac users. You can see other methods in the **rdocumentation** of `download.file` or just type `?download.file()` in the Rconsole. 
> method = "curl" → for mac users

> method = "wininet" → for windows users
```
download.file(dataset_url, destfile="./data/exdata_data_household_power_consumption.zip", method = "wininet")
```
Now that we have downloaded the zip file, we need to unzip the file.
```
unzip("exdata_data_household_power_consumption.zip")
```
Now, lets see what was in the zip file and what have we unziped and read accordingly.
```
list.files("./data",  all.files=T)
```
Here, `"./data"` list the files in the directory ** data** and `all.files=T` list all the files hidden or visible. You can also set the argumet `all.files=F` to see only the visible files. 
You will receive something like this.
`"exdata_data_household_power_consumption.zip" "household_power_consumption.txt" `
So, there is .zip file we have downloaded and there is .txt file we found after unzipping the zip file.
### Possible Problem: 
Here, you can face a possible problem that, when you run the above code, you may get `>character(0)`.
### Solution:
If you are already inside the **"data"** directory, it will return `>character(0)` because your working directory is inside **"data"** and no files named **"data"** in there. Move one directory up to see the files in there.

Now, lets get back. We have a .txt file to read. Here, `read.csv()` will not work because it is not a .csv or comma separated file. Hence, .txt means the values are tab separated. We can use `read.delim()` or `read.table()`.

>`read.delim()` is used to read delimited text files where data is organized in a data matrix with rows representing cases and column representing variables. 

>`read.table()` reads a file in a table format and creates a data frame from it.

Now, lets read the file.
```
power_consumption_data <- read.table("./data/household_power_consumption.txt")
```
Now, lets see what we have just read. Lets just see the head of the file what we have read.
```
head(power_consumption_data)
```
```
V1
1 Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
2                                                         16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
3                                                         16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
4                                                         16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000
5                                                         16/12/2006;17:27:00;5.388;0.502;233.740;23.000;0.000;1.000;17.000
6                                                         16/12/2006;17:28:00;3.666;0.528;235.680;15.800;0.000;1.000;17.000
```
oppps, what are this things? First of all, they are not clear to understand and there is an extra column named V1. Lets correct these things. If we set the argument `header= T`, value is then determined from file format. So, lets try it.
```
power_consumption_data <- read.table("./data/household_power_consumption.txt", header=TRUE)
head(power_consumption_data)
```
```
 Date.Time.Global_active_power.Global_reactive_power.Voltage.Global_intensity.Sub_metering_1.Sub_metering_2.Sub_metering_3
1                                                         16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
2                                                         16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
3                                                         16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000
4                                                         16/12/2006;17:27:00;5.388;0.502;233.740;23.000;0.000;1.000;17.000
5                                                         16/12/2006;17:28:00;3.666;0.528;235.680;15.800;0.000;1.000;17.000
6                                                         16/12/2006;17:29:00;3.520;0.522;235.020;15.000;0.000;2.000;17.000
```
Now, the extra column V1 has gone. But still the columns are not clearly separated. This is because by default .txt files are separated by "."(dot). When we look at the file the values are congested. We need to separate them using ";" which is much clearer. We can do this by seting the *sep* argument as *";"*.
```
power_consumption_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";")
head(power_consumption_data)
```
```
 Date     Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
1 16/12/2006 17:24:00               4.216                 0.418 234.840           18.400          0.000          1.000             17
2 16/12/2006 17:25:00               5.360                 0.436 233.630           23.000          0.000          1.000             16
3 16/12/2006 17:26:00               5.374                 0.498 233.290           23.000          0.000          2.000             17
4 16/12/2006 17:27:00               5.388                 0.502 233.740           23.000          0.000          1.000             17
5 16/12/2006 17:28:00               3.666                 0.528 235.680           15.800          0.000          1.000             17
6 16/12/2006 17:29:00               3.520                 0.522 235.020           15.000          0.000          2.000             17

```
Now, they are organised in well form. However, as described in the question, missing values are coded as **"?"**. We stripped the values indicating  **"?"** with  **na.strings** arguments.
```
power_consumption_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
head(power_consumption_data)
```
```
 Date     Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
1 16/12/2006 17:24:00               4.216                 0.418  234.84             18.4              0              1             17
2 16/12/2006 17:25:00               5.360                 0.436  233.63             23.0              0              1             16
3 16/12/2006 17:26:00               5.374                 0.498  233.29             23.0              0              2             17
4 16/12/2006 17:27:00               5.388                 0.502  233.74             23.0              0              1             17
5 16/12/2006 17:28:00               3.666                 0.528  235.68             15.8              0              1             17
6 16/12/2006 17:29:00               3.520                 0.522  235.02             15.0              0              2             17
```
Now, we have the data set loaded in **power_consumption_data**. Lets see the class of the data.
```
class(power_consumption_data$Global_active_power)
class(power_consumption_data$Date)
```
It will return as:
```
"factor"
"factor"
```
Opps, all the data are loaded as factors. So, what is a factor? 

Facotors are variables in R which take on a limited number of different values, such variables are often refered to as categorical variables. oooo Gone way above the head! Lets be clear with an example. Lets create a vector named data and store 3 character values named A, B, C.
```
data = c("A", "B", "C")
m = factor(data)
m
>A B C
Levels: A B C
```
Here, we used char variables to create category. We can also create category using integers like below:
```
data = c(1,2,3)
m = factor(data)
m
>1 2 3
Levels: 1 2 3
```
So, factors are a class to represent category. They are not integers nor even characters. If we load the dataset as factors the whole data could not be used as integers or characters but our data is given mostly as integers. An we can not subset or put any arithmatic operation on our data because only factor operations (like interaction, nesting etc.) can be applied on a factor. 

There is a argument called **colclass** to determine the class we want the data to be loaded as while reading. So, lets define the claass of every column we want to load the data as.
```
power_consumption_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
```
Now, if we check the class of the column, we will see the correct formats we loaded data as. ***Ok! We have successfully loaded the data set. 1st step is complete.***

## **Step 02: Subset the desired data.**
Now, we want to subset data from 2007-02-01 to 2007-02-02. We have a separate **Date** class in R to represent dates. So, we can convert the dates in variable and compare it with another date class. Default date format in R is **Year-Month-Day**. If we look at our data, dates are given as **Date/Month/Year**. So, we have to tell R the way we want to input date. So, we use the formate argument to specify date input format.
```
power_consumption_data$Date <- as.Date(power_consumption_data$Date, format = "%d/%m/%Y")
```
Here, `as.Date()` function converts the *Date* column to Date class which was previously in character. It receives the dates as **Date/Month/Year** format. Now, if we look at the *Date* column in the dataset and check the class:
```
head(power_consumption_data$Date)
 > "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16"
class(power_consumption_data$Date)
>"Date"
```
So, the *Date* column is now in Date class. 
###**Possible Problem:***
While formating the dates in format argument. If we use '%y' it will read only 1st two element of the year. So, when you will look up the data it will always show the 1st 2 digits with a 4 numbering format. This may create a severe problem. So, use %Y if you have a 4 digit year in the given data.

Now, lets get back to the subsetting. We need to subset the data between the given dates.
```
power_consumption_data <- subset(power_consumption_data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
```
Now if we look at the data.
```
 Date     Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
 2007-02-01 00:00:00               0.326                 0.128  243.15              1.4              0              0              0
 2007-02-01 00:01:00               0.326                 0.130  243.32              1.4              0              0              0
 2007-02-01 00:02:00               0.324                 0.132  243.51              1.4              0              0              0
 2007-02-01 00:03:00               0.324                 0.134  243.90              1.4              0              0              0
 2007-02-01 00:04:00               0.322                 0.130  243.16              1.4              0              0              0
 2007-02-01 00:05:00               0.320                 0.126  242.29              1.4              0              0              0
```
Now, we have our desired data. Wait what! We have used arithmatic operations like >= and <= on date class. But how is it possible? Because dates in R generally have a numeric mode.

Now, we have successfully filtered our desired data on our desired dates. ***Step 02 complete***
## **Step 03: Date and Time to Date/Time class**

Instruction number 3 said clearly that, we need to convert the Date and Time in Date/Time class. For this lets 1st combine date and time column.
```
DateTime<- paste(power_consumption_data$Date, power_consumption_data$Time)
```
We have just created a separate vector naming DateTime containing the values of Date and Time together for each element in the vector. Now, lets clean the Date and Time column in data set. Easiest way to do so is just submitting them to Null.
```
power_consumption_data$Date <- power_consumption_data$Time<- NULL
```
Now, if we look at the data set again, we will see there is no column named Date and Time.
```
head(power_consumption_data)
```
```
      Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
66637               0.326                 0.128  243.15              1.4              0              0              0
66638               0.326                 0.130  243.32              1.4              0              0              0
66639               0.324                 0.132  243.51              1.4              0              0              0
66640               0.324                 0.134  243.90              1.4              0              0              0
66641               0.322                 0.130  243.16              1.4              0              0              0
66642               0.320                 0.126  242.29              1.4              0              0              0
```
Lets combine the **DateTime** vector with the dataset.
```
power_consumption_data<- cbind(DateTime, power_consumption_data)
```
Here, we column binded both and used the vector 1st which makes the vector to be attached as the 1st column in the datase. If we have used the dataset name 1st, it would add the vector at last of the dataset. 
Now, lets look at the data set again
Now, if we look at the data set again, we will see there is no column named Date and Time.
```
head(power_consumption_data)
```
```
       DateTime          Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
 2007-02-01 00:00:00               0.326                 0.128  243.15              1.4              0              0              0
 2007-02-01 00:01:00               0.326                 0.130  243.32              1.4              0              0              0
 2007-02-01 00:02:00               0.324                 0.132  243.51              1.4              0              0              0
 2007-02-01 00:03:00               0.324                 0.134  243.90              1.4              0              0              0
 2007-02-01 00:04:00               0.322                 0.130  243.16              1.4              0              0              0
 2007-02-01 00:05:00               0.320                 0.126  242.29              1.4              0              0              0
```
If we look at the class of the DateTime column we have just added. We will find out that it is a facotr.
```
class(power_consumption_data$DateTime)
> "factor"
```
It is not desirable. There is separate DateTime class in R to represent Date/Time. There are two basic classes of date/times. **"POSIXct"** is more convenient for including in data frames, and **"POSIXlt"** is closer to human-readable forms. Now, lets convert the factor variables in DateTime column in Date/Time class using `as.POSIXct()`:
```
power_consumption_data$DateTime <- as.POSIXct(DateTime)
```
Okay, Our basic preperation for the data set is done. ***Step 03 complete***
## **Step 04: Plotting**
#### *Plot 01:*
Lets create a seperate .R file naming it as plot1.R and construct a png file with the given height and weidth in the question.
```
png(file = "plot1.png", width=480, height=480)
```
Lets create a histogram with `hist()`, namie it with main argument, declare labels of x and y with xlab and ylab; precise color with col argument.
```
hist(power_consumption_data$Global_active_power, main= "Global Active Power", xlab = "Global Active Power(kilowatts)", ylab = "Frequency", col = "red")
```
Then close the graphic device png with `dev.off` [This is important]
```
dev.off()
```
***Plot 01 Done***
#### *Plot 02:*
Lets initiate a png graphic device with different .R file same as plot 1. Then, plot Global_active_power~DateTime give it a name, lable the axis and select the plot type. In my case, i selected `type="l"` for drawing the plot as lines. There are several options for where yo can choose also. 
```
with(power_consumption_data, plot(DateTime, Global_active_power, type = "l",  ylab="Global Active Power (kilowatts)", xlab=""))
```
Now just close it as plot 1.
#### *Plot 03:*
Lets initiate a png graphic device with different .R file same as plot 1. Then, plot Sub_metering_1~DateTime, Sub_metering_2~DateTime, Sub_metering_3~DateTime give them names, lable the axis and select the plot type also define colors.
```
with(power_consumption_data, {plot(DateTime, Sub_metering_1, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
    lines(DateTime, Sub_metering_2, col = "red") 
    lines(DateTime, Sub_metering_3, col = "blue")})
 ```
Finally, we add a legend with the `legend()` function explaining the meaning of the different colors in the plot.
```
legend("topright", col = c("black", "red", "blue"), lwd=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
```
Here, we define it to be on the topright corner of the plot, define the colors creating a color vector. We defined line width then instruct the join the colors with their annotation.
Now just close it as plot 1.
#### *Plot 03:*
Lets initiate a png graphic device with different .R file same as plot 1. But here we have multiple graphs. What to do?

With `par()` we can put multiple graphs in a single plot by setting some graphical parameters with the help of `par()` function. Graphical parameter **mfrow** can be used to specify the number of subplots we need. `par()` takes a vector of form c(m, n) which divides the given plot into m*n array of subplots. For example, if we need to plot two graphs side by side , we would have m=1 and n=2. The same phenomenon can be acheived with graphical parameter `mfcol`. The only difference between two is that, `mfrow` fills in the subplot region rowwise while mfcol fills it column wise. For clear understanding:
```
par(mfrow = c(2,1), mar = c(4,4,2,1))
```
Here, `mfrow = c(2,1)` set the plotting area into a 2*1 array and mar = c(4,4,2,1) is a numeric vector of length 4, which sets the margin sizes in the following order: bottom, left, top and right. The default is c(5.1, 4.1, 4.1, 2.1).


Now lets get back to work. 1st declare a par function defining rows and margin and also the size of legend using `oma` argument.
```
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
```
Now just plot the varibales, give them names, lable the axis and select the plot type also define colors and legend. Now just close it as plot 1.


# **The End**


# **Thank You For being here**
