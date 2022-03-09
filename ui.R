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
      
      selectInput(inputId = "selected_sector",
                  label = "Select sector:",
                  choice = unique(stocks$gics_sector)
      )
    ),
    mainPanel(
      plotOutput("stock_plot"),
      
      br(),
      
      tableOutput("stock_info"),
      
      plotOutput("ts_plot")
    )
  )
)
