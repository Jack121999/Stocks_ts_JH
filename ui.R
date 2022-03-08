library(shiny)
library(fpp3)

ui <- fluidPage(
  selectInput(inputId = "selected_sector",
              label = "Select sector:",
              choice = unique(stocks$gics_sector)
  ),
  
  tableOutput("stock_info"),
  
  plotOutput("ts_plot")
  
)