tagList(

  whats_thisUI("holtwinters"),
  br(),
  
  # h4("Forecast with Holt-Winters"),
  # h6("A Holt-Winters model describes the correlations within a series of data and uses that information to forecast future events."),

  
  sidebarLayout(
    sidebarPanel(
      warningUI("arimadatewarn"),
      warningUI("forecast"),
      pickerInput("selectTimeVar", "Select the variable representing time:", choices=NULL, selected = NULL, multiple = FALSE),
      selectInput("selectForecastVar", "Select the variable to forecast:", choices=NULL,  multiple=FALSE),
      selectInput("selectFrequency", "Select unit of time:", 
                  choices = c(
                      "Days" = 365,
                      "Weeks" = 52,
                      "Months" = 12,
                      "Quarters" = 4,
                      "Years" = 1
                    )
                  ),
      numericInput("selectNumObs", "Enter how many future observations to forecast:", 500),
      actionButton("fitHW", "Fit Model")
      ),
    mainPanel(
      plotlyOutput("hw_plot")
    )),
  
  br(),
  br(),
  uiOutput("hw_download"),
  dataTableOutput("hw_table"),
  br()
  # whats_thisUI("holtwinters")
  
)