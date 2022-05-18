library(cluster)
library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(randomForest)
library(plotly)
library(shinyjs)
library(ggplot2)
library(leaflet)
#library(tmap)
library(rgdal)
library(pdp)
#library(sf)
#library(jtools) #used for regression results
library(data.table)
library(nnet)  # for logistic regression
library(geometry) #used to find convex hulls in the kmeans plot
library(htmlwidgets)
library(class)
library(shinyWidgets)
library(forecast)
library(openxlsx)
library(htmlTable)
library(factoextra)
library(broom)
library(viridis)
library(shinycssloaders)
library(leaflet.extras)
library(RgoogleMaps)
library(servr)
library(sf)
library(totalcensus)
library(openintro)
library(mlbench)
library(caret)
library(lubridate)
# This scripts reads in the datasets to be used and outputs a list of them
library(stringr)
library(dendextend)
library(RColorBrewer)

#library(summarytools) #data summary made easy
### Census data and Google related packages loading
# add option for larger upload files
options(shiny.maxRequestSize=100000*1024^2)

source("module/whats_this_module.R")
source("module/warning_module.R")


#the data must be saved as a reactive values and be available in the global scope to be used across tabs. We may have to use the <<- operator to do this
master <- reactiveValues(
  date = Sys.time(),
  description = NULL,
  dataframe = NULL,
  train = NULL,
  test = NULL,
  coltypes = NULL,
  counter = 0,


  #model types
  model_regress =NULL,
  model_multinom = NULL,
  
  # visualization: NB: gganimate needs to be added
  model_corr = NULL,
  model_histogram = NULL,
  
  #comparison
  validate = NULL
)

html_helpers <- reactiveValues(
  warning = NULL,
  lin_reg_trigger = FALSE
)

pred <- reactiveValues(
  reg = NULL
)


#sourcing static text elements- these include descriptions, text for landing pages, and warnings
source("text_elements/descriptions.R")
source("text_elements/landing pages.R")
source("text_elements/warning_messages.R")


#creating a unified font for text in plots
plot_font <- list(family = "Calibri", color = "#707070")

#function to scale between 1 and 0
range01 <- function(x){(x-min(x))/(max(x)-min(x))}

styles = list(
  #creating header style
  row_style = createStyle(fgFill = "#000034", #fgFill colors the cells
                          numFmt = "GENERAL", #numFmt formats numbers in particular styles like date or accounting,
                          border = "TopBottomLeftRight",
                          fontColour = "white"
  ),

  #create style for total rows
  total_style = createStyle(fgFill = "#A9A9A9", #fgFill colors the cells
                            numFmt = "GENERAL", #numFmt formats numbers in particular styles like date or accounting,
                            border = "TopBottomLeftRight",
                            textDecoration = "Bold"
  ),

  #create style for all the cells
  all_style = createStyle(border = "TopBottomLeftRight"),

  #titles for both the sheets and tables
  title_style = createStyle(fontSize = 12, textDecoration = "Bold"),
  big_style = createStyle(fontSize = 16, textDecoration = "Bold")
)
