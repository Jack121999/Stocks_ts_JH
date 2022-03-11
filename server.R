library(shiny)
library(fpp3)
library(dplyr)

server <- function(input, output) {
  
  output$stock_info <- renderTable({
    
    stocks <- stocks[stocks$gics_sector == input$selected_sector,]
    
    top_vol <- stocks %>% 
      group_by(symbol) %>% 
      summarise (avg_vol = mean(volume)) %>% 
      arrange(desc(avg_vol)) %>%
      head(3)
    
    top_vol
    
  })
  
  main_plot_df <- reactive({
    ts_df <- stocks %>% 
      filter(security %in% input$selected_stocks)
    ts_df[c(1,2, as.integer(input$select))] %>%
      as_tsibble(index = "date", key = "symbol") %>%
      filter(date >= input$date[1],
             date <= input$date[2])
  })
  
  output$stock_plot <- renderPlot({
    autoplot(main_plot_df())
  })
  
  plot_df <- reactive({
    stocks <- stocks[stocks$gics_sector == input$selected_sector,]
    
    top_vol <- stocks %>% 
      group_by(symbol) %>% 
      summarise (avg_vol = mean(volume)) %>% 
      arrange(desc(avg_vol)) %>% 
      head(3)
    
    filtered_stocks <- stocks %>% 
      filter(stocks$symbol %in% top_vol$symbol) %>% 
      mutate(volume = log(volume))
    
    my_df <- as_tsibble(
      filtered_stocks,
      index = "date",
      key = "symbol"
    ) 
    
})
  
  output$ts_plot <- renderPlot({
    
    autoplot(plot_df(), volume) +
      labs(title = "Top Stocks for Selected Sector by Volume") 
  })
}

