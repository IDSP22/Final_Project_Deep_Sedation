tagList(
  
  whats_thisUI("regression"),
  
  br(),
  
  fluidRow(column(width = 12, warningUI("linregwarn"))),
  
  br(),
  
  # h4("Predict Linear Relationships with Regression"),
  # h6("A linear regression models the relationship between quantitative variables by fitting a single line based off the predictor variables that is closest to the data points of the response variable."),
  
  
  fluidRow(
    # select predictor variables
    column(width = 4, pickerInput("regress_pred", "Select predictor variables to fit model to:", choices=NULL, selected = NULL, multiple = TRUE)),
    
    # select response variable
    column(width = 4, selectInput("regress_response", "Select response variable:", choices=NULL,  multiple=FALSE)),
    
    # fit model button
    column(width = 4, actionButton("run_regress", "Run Regression"))          
    
  ),
  
  uiOutput("regression_results"),
  
  plotlyOutput("regression_plot"),
  
  uiOutput("regress_table_title"),
  
  dataTableOutput("regression_table"),
  
  uiOutput("regress_download", align = "center"),
  
  br(),
  
  hidden(div(class = "landingpage_side", id = "regress_wrap", "test")),
  
  div(class = "landingpage_side",
      
      fluidRow(
        column(10, uiOutput("input_ui")),
        column(2, uiOutput("table"))
      ))
  
  # whats_thisUI("regression")  
)