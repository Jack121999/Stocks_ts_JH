library(shiny)
library(fpp3)

server <- function(input, output) {
  
  output$stock_info <- renderTable({
    
    stocks <- stocks[stocks$gics_sector == input$selected_sector,]
    
    selected_volume <- head(sort(stocks$volume, decreasing = TRUE), n = 3)
    
    filtered_volume <- stocks %>% 
      filter(volume %in% selected_volume)
    
    
    filtered_stocks <- stocks %>% 
      filter(symbol %in% unique(filtered_volume$symbol)) %>% 
      mutate(volume = log(volume))
    
    unique(filtered_stocks[,c(1,9)])
    
  })
  
  main_plot_df <- reactive({
    ts_df <- stocks %>% 
      filter(security %in% input$selected_stocks) %>%
      as_tsibble(index = "date", key = "symbol") %>%
      filter(date >= input$date[1],
             date <= input$date[2])
  })
  
  output$stock_plot <- renderPlot({
    autoplot(main_plot_df(), close) +
      labs(title = "Closing Price")
  })
  
  plot_df <- reactive({
    stocks <- stocks[stocks$gics_sector == input$selected_sector,]
    
    selected_volume <- head(sort(stocks$volume, decreasing = TRUE), n = 3)
    
    filtered_volume <- stocks %>% 
      filter(volume %in% selected_volume)
    
    
    filtered_stocks <- stocks %>% 
      filter(symbol %in% unique(filtered_volume$symbol)) %>% 
      mutate(volume = log(volume))
    
    
    ts_df <- as_tsibble(
      filtered_stocks,
      index = "date",
      key = "symbol",
      
    ) 
    
  })
  
  output$ts_plot <- renderPlot({
    
    autoplot(plot_df(), volume) +
      labs(title = "Top Stocks for Selected Sector by Volume") 
  })
}

