tagList(
    # '.box.box-solid.box-info>.box-header { background-color: darkred} '
  fluidRow( #begin fluidrow for csv upload
    box(width = 12, title = "Upload Flat Data", status = "info", solidHeader = T, #i changed the css for status info to that booz allen green
        fluidRow( #fluidrow for csv controls
          # tags$class("collect"), 
          # column(4,
          #        numericInput(
          #          "samplesize",
          #          "Choose the Sample Size for your Upload",
          #          10000, 1, 500000
          #        )),
          column(4,fileInput(inputId = "file", "Choose CSV File",
                             accept = c(
                               "text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv")))#,
          #column(4,selectizeInput("select_columns","Select Columns",choices=c(), multiple =T)),
          #column(4, actionButton("save", "Save Changes"))
          ),
        fluidRow(column(width = 12, uiOutput("sample_warning"))),
        uiOutput("collect_descript"),
        br(),
        dataTableOutput("tab1")
    )#end box
  )
  
)
