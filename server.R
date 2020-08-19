
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(readr)
#filename <- "/Users/alexhumfrey/Documents/Data Science Coursera/Scripts/Developing Data Products/Life_Expectancy_App/life_expectancy_years.csv"
life_exp_data <- read.csv("life_expectancy_years.csv", header = FALSE)

# convert first variable country to row names(indexpl)
life_exp_data <- data.frame(life_exp_data[,-1], row.names = life_exp_data[,1])

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    filtered_data <- reactive({
        
        include_list <- c("country", input$Country1, input$Country2, input$Country3, input$Country4)
        
        life_exp_data <- subset(life_exp_data, rownames(life_exp_data) %in% include_list)
        life_exp_data <- life_exp_data[,(input$years[1]-1799):(input$years[2]-1799)]
        life_exp_data <- life_exp_data[, life_exp_data[1, ] >= input$years[1] & life_exp_data[1,] <= input$years[2]]
        life_exp_data <- as.data.frame(t(life_exp_data))
        
        life_exp_data
    }) 
   
  output$life_exp_plot <- renderPlotly({
      
      ggplotly({
          life_exp_data <- filtered_data()
          
          g <- life_exp_data %>% ggplot( aes(x=country, y=life_exp_data[,input$Country1])) + geom_line(color = "blue") +
              geom_line(aes(y = life_exp_data[,input$Country2]), color = "red")+
              geom_line(aes(y = life_exp_data[,input$Country3]), color = "green")+
              geom_line(aes(y = life_exp_data[,input$Country4]), color = "yellow")+
              labs(x = "Years", y = "Life Expectancy") 
          
      })
      g
  })
  
})
