setwd("D://exdata_data_household_power_consumption")

library(data.table)
library(dplyr)

raw_data <- fread(input = "household_power_consumption.txt",
                  sep = ";", 
                  na.strings = "?")
raw_data <- tbl_df(raw_data)
raw_data <- mutate(raw_data, 
                   date_time = paste(Date, Time),
                   new_date = as.POSIXct(Date, 
                                         format = "%d/%m/%Y"),
                   new_time = as.POSIXct(date_time, 
                                         format = "%d/%m/%Y %H:%M:%S"))
filtered <- raw_data[which(raw_data$new_date == '2007-02-01' | 
                             raw_data$new_date == '2007-02-02'),]

#plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(filtered$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col='red')
dev.off()
