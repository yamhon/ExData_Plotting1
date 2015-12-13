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

#plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(y = filtered$Sub_metering_1, 
     x = filtered$new_time,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     col = "black")
lines(y = filtered$Sub_metering_2, 
      x = filtered$new_time,
      col = "red")
lines(y = filtered$Sub_metering_3, 
      x = filtered$new_time,
      col = "blue")
legend(x = "topright",
       lty = 1,
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        )
dev.off()
