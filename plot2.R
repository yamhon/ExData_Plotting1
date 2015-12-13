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

#plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(y = filtered$Global_active_power, 
     x = filtered$new_time,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
