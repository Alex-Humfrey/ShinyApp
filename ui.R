
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(readr)
#filename <- "/Users/alexhumfrey/Documents/Data Science Coursera/Scripts/Developing Data Products/Life_Expectancy_App/life_expectancy_years.csv"
life_exp_data <- read.csv("life_expectancy_years.csv", header = FALSE)

# convert first variable country to row names(indexpl)
life_exp_data <- data.frame(life_exp_data[,-1], row.names = life_exp_data[,1])

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Gapminder Data comparing life expectancy of different countries between 1800 and 2100"),
    h4("The average number of years a newborn child would live if current mortality patterns were to stay the same"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        h3("Select Countries and Years below, click submit to see the visualisation"),
        selectInput("Country1", "Choose a Country", choices = rownames(life_exp_data)),
        selectInput("Country2", "Choose a Country", choices = rownames(life_exp_data)),
        selectInput("Country3", "Choose a Country", choices = rownames(life_exp_data)),
        selectInput("Country4", "Choose a Country", choices = rownames(life_exp_data)),
       sliderInput("years", "Select Timescale",
                   min = 1800,
                   max = 2100,
                   value = c(1800,2100)),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        h3("Figure comparing the estimated life expectancy for different countries over time"),
       plotlyOutput("life_exp_plot")
    )
  )
))
