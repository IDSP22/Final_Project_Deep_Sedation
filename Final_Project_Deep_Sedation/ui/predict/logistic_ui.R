tagList(
  #whats_thisUI("logit_description"),
  br(),
  
# h4("Model Classification Relationships with Logistic Regression"),
# h6("A multinomial logistic regression models the relationship between quantitative variables and a categorical response variable by fitting a logistic function to predict the probabilities of the different possible outcomes of the categorically distributed response variable."),

  fluidRow(
    # selectInput("multinom_pred", "Select predictor variables to fit model to:", choices=NULL, multiple = TRUE),
    
    column(4,
    pickerInput("multinom_pred", "Select predictor variables to fit model to:", choices=NULL, selected = NULL, multiple = TRUE)),
    column(4,
    selectInput("multinom_response", "Select response variable:", choices=NULL,  multiple=FALSE)),
    column(4,
    actionButton("fit_multinom", "Fit Model"))
  ),
  uiOutput("multinom_describe_text"),
            br(),
            plotlyOutput("multinom_plot"),
            # fluidRow(
            #   column(width = 6, selectInput("multinom_viz_xvar", "Select x variable:", choices=NULL, multiple = FALSE) ),
            #   column(width = 6, selectInput("multinom_viz_class", "Select y variable::", choices=NULL,  multiple=FALSE))
            # ),
            uiOutput("multinom_model_summary_title"),
            uiOutput("multinom_model_summary_note"),
            br(),
            uiOutput("multinom_coefficients_title"),
            dataTableOutput("multinom_coefficients_table"),
            br(),
           # uiOutput("multinom_coefficient_standard_errors_title"),
           # dataTableOutput("multinom_coefficient_standard_errors_table"),
           # br(),
            uiOutput("multinom_coefficient_p_values_title"),
            dataTableOutput("multinom_coefficient_p_values_table")
           # whats_thisUI("logit_description")
  

)