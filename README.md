
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
```
