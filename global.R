stocks <- read.csv("nyse_stocks.csv")

stocks$date <- as.Date(stocks$date)