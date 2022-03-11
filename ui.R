library(shiny)
library(shinyWidgets)
library(fpp3)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(version = 4, bootswatch = "minty"),
  h1("Stock Data"),
  sidebarLayout(
    sidebarPanel(
      multiInput(inputId = "selected_stocks", label = "Select Stocks to Plot:", choices = unique(stocks$security), selected = "Apple Inc."),
      selectInput("select", label = "Select Statistic", 
                  choices = list("Open" = 4, "Close" = 5, "Low" = 6, "High" = 7, "Volume" = 8), 
                  selected = 4),
      selectInput(inputId = "selected_sector",
                  label = "Select sector:",
                  choice = unique(stocks$gics_sector),
      ),
      
      dateRangeInput(inputId = 'date',
                     label = 'Select Date Range',
                     start = min(stocks$date),
                     end = max(stocks$date),
                     min = min(stocks$date),
                     max = max(stocks$date),
      )
      ),
    mainPanel(
      plotOutput("stock_plot"),
      
      br(),
      
      tableOutput("stock_info"),
      
      plotOutput("ts_plot"),
      )
    )
)