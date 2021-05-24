#Libraries
library(ggplot2)
library(tidyverse)
library(dplyr)
library(tidyr)
library(ggthemes)

#Get WD .csv
getwd()
draft_data = read.csv('/Users/jmoral23/Documents/draft_data.csv', stringsAsFactors = F)
people = read.csv('/Users/jmoral23/Documents/people.csv', stringsAsFactors = F)
draft_data
people

#Merging Data Files in to one Data Frame, using outer join in order to return all rows from both tables, joining matching keys of mlbamPlayerID to key_mlbam.
mlbdraftdata = merge(draft_data,people,by.x = c("mlbamPlayerID"),by.y = c("key_mlbam"),all = TRUE)

#Filtering out the 17th overall picks from the merged data frame
seventeeth_overallpicks= mlbdraftdata%>%
  select(name_first_last, year, overall)%>%
  filter(overall == "17")%>%
  arrange(year)

seventeeth_overallpicks

#Dataframe created to add signing bonus of 17th overall players, Source: Baseball Reference
seventeeth_overallpicks$signingbonus = c(57500,67500,60000,70000,100000,125000,125000,100000,126000,188000,192500,250000,410000,450000,450000,895000,900000,975000)
seventeeth_overallpicks

#Dataframe created based on 2019 CPI Index to adjust signing bonus to 2019, Source: Federal Reserve Bank of Minneapolis
seventeeth_overallpicks$CPI = c(247.6,273.2,290.0,299.3,312.2,323.2,329.4,341.4,355.4,372.5,392.6,409.3,421.7,434.1,445.4,457.9,471.3,482.4)
seventeeth_overallpicks

#Calculated Signing bonus in 2019 based on CPI Adjusted Formula, Source: Federal Reserve Bank of Minneapolis
seventeeth_overallpicks$signingbonusesCPIadjusted = seventeeth_overallpicks$signingbonus * (768.3/seventeeth_overallpicks$CPI)
seventeeth_overallpicks

#Mean of all signing bonuses
mean(seventeeth_overallpicks$signingbonusesCPIadjusted)