library(readr)
stocks <- read_csv("nyse_stocks.csv.zip")

stocks$date <- as.Date(stocks$date)