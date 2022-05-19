tagList(

  whats_thisUI("rf"),

  br(),
  
  # h4("Predict and Classify with Random Forest"),
  # h6("A random forest model builds multiple decision trees and aggregates the results to predict the response variable."),

  
  fluidRow(column(width = 12, warningUI("randomforestwarn"))),
  fluidRow(column(width = 12, warningUI("randomforestwarn2"))),
  br(),
  
  fluidRow(
    # warning message in case user selects fewer than four predictor variables
    # warningUI("randomforestwarn"),
    
    # select predictor variables
    column(width = 3, pickerInput("selectPredVar", "Select predictor variables:", choices=NULL, selected = NULL, multiple = TRUE)),
    
    # select response variable
    column(width = 3, selectInput("selectRespVar", "Select response variable:", choices=NULL,  multiple=FALSE)),
    
    # fit model button
    column(width = 3, div(actionButton("fitModel", "Fit Model")), align = "center"),
    column(width = 3, uiOutput("rf_download"))
    
  ),
  
  
  fluidRow(
    # Show random forest performance metric
    column(width = 12, uiOutput("rf_performance"))
  ),
  
  br(),
  
  fluidRow(
    column(width = 6, plotlyOutput("rf_VarImp")),
    column(width = 6,  uiOutput("rf_second_plot"),
           textOutput("batting_average"))
  ),
  div(class = "landingpage_side",
      fluidRow(
        column(10, uiOutput("input_ui2")),
        column(2, uiOutput("table2"))
      )
  )
  
  # whats_thisUI("rf")
)