###            Pre-Process: Installing Packages and Updating Library        ###

install.packages("readxl")
library(readxl)
library(tidyverse)
library(stringr)





###                                Alaska Data Set                           ###

alaska <- read_xlsx(path = "Alaska.xlsx")

#Evaluating data for formating issues
head(alaska)
str(alaska)

###Date correction###

#Make character string for day and month
yr <- as.character(alaska$year)
mt <- as.character(alaska$month)

#Add an 0 in front of the month to make it a two-digit format
mt <- str_c("0",mt, sep = "")

#Combine year and month into one column
yr_mt <- str_c(yr,mt,sep = "-")
head(yr_mt)

#Add the new correctly formatted date string to the existing dataset
alaska$date <- yr_mt

#Check that it worked
str(alaska)

#Create a CSV with the data correctly formatted for Long/Lat and Date
write.csv(x = alaska, file = "Alaska_fixed.csv", row.names = F)






###                           Peru Data Set                                 ###

p <- read_xlsx(path = "Peru.xlsx")

#Evaluating data for formating issues
head(p)
str(p)

###Date correction###

#Make character string for day and month
yr_p <- as.character(p$year)
mt_p <- as.character(p$month)
str(yr_p)
str(mt_p)

#Add an 0 in front of the month to make it a two-digit format
mt_p <- str_c("0",mt_p, sep = "")
str(mt_p)

#Combine year and month into one column
yr_mt_p <- str_c(yr_p,mt_p,sep = "-")
head(yr_mt_p)

#Add the new correctly formatted date string to the existing dataset
p$date <- yr_mt_p

#Check that it worked
str(p)
head(p)


###                         Long-Lat correction: Peru                       ###


a <- as.numeric(str_extract(p$LAT, "^[0-9]+"))
b <- str_extract(p$LAT, "[0-9]*\\.?[0-9A-Za-z]*$")
c <-as.numeric(str_extract(b, "^[0-9]*\\.?[0-9]*"))

str(a)
str(b)
str(c)

min <- c/60
head(min)

deg.lat <- (a + min)*-1

head(deg.lat)

p$LAT <- deg.lat

head(p)

A <- as.numeric(str_extract(p$LONG, "^[0-9]+"))
B <- str_extract(p$LONG, "[0-9]*\\.?[0-9A-Za-z]*$")
C <-as.numeric(str_extract(B, "^[0-9]*\\.?[0-9]*"))

str(A)
str(B)
str(C)

deg.long <- (A + C/60)*-1
head(deg.long)

p$LONG <-deg.long

head(p)

#Create a CSV with the data correctly formatted for Long/Lat and Date
write.csv(x = p, file="Peru_fixed.csv")







###                           GOM Data Set (Date change only)                              ###

gom <- read_xlsx(path = "GOM_XL.xlsx")

#Evaluating data for formating issues
head(gom)
str(gom)

###Date correction###

#Make character string for day and month
yr <- as.character(gom$Year)
mt <- as.character(gom$Month)

#Add an 0 in front of the month to make it a two-digit format
mt <- str_c("0",mt, sep = "")

#Combine year and month into one column
yr_mt <- str_c(yr,mt,sep = "-")
head(yr_mt)

#Add the new correctly formatted date string to the existing dataset
gom$date <- yr_mt

#Check that it worked
str(gom)

#Create a CSV with the data correctly formatted for Long/Lat and Date
write.csv(x = gom, file = "GOM_fixed.csv", row.names = F)


