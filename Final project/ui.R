# Assignment 1

# Calling libraries

library(shiny)

# Defining the user interface. What is display in the web page. Showing all the built-in 
# data frames included in the data sets packages. 

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Patient's deep sedation accross ethnicities"),
  mainPanel(
    
    tabsetPanel( 
      tabPanel("Simulation"),
      
      tabPanel("Deeply sedation over first 5 days"),
                 mainPanel(
                   verbatimTextOutput("show_model")
                 ),
      tabPanel("Mortality after 90 days"),
      mainPanel(
        verbatimTextOutput("show_model")
      )
                 
               )
      )
    )
  )
      

