function(input, output, session){
  
  rv <- reactiveValues(download_flag = 0)
  
  
  # as a function of loading in data, the collect tab cannot be sourced. its very small though
  # Collect Tab -------------------------------------------------------------
  source("server/downloadworkbook.R", local=T)
  
  
  
  filedata <- reactive({
    req(input$file)
    ext <- tools::file_ext(input$file$name)
    switch (ext,
            csv = vroom::vroom(input$file$datapath, delim = ","),
            validate("Invalid file; Please upload a .csv file") #Verify the type of file that is uploaded
    ) #Read csv_file; this could later be updated to accept different types of data.
  })

  #on the first tab we manipulate the data and save it for use in the other tabs
  output$tab1 <- renderDataTable({
    
    master$dataframe <- filedata()
    
    sample <- sample.int(n = nrow(master$dataframe), size = floor(.75*nrow(master$dataframe)), replace = F)
    master$train <- master$dataframe[sample, ]
    master$test  <- master$dataframe[-sample, ]
    # this function uploads the data
    # if(input$save == 0){
    #   master$dataframe <- filedata()
    # } else {
    #   observeEvent(input$save, {
    #     master$dataframe <- filedata()[,input$select_columns]
    #   })
    # }
    
    temp <<- master$dataframe
    
    #to reduce code, creating a list of commonly used coltypes
    
    if(!is.null(master$dataframe)){
      
      
      numbers <- names(master$dataframe[unlist(lapply(master$dataframe, is.numeric))])
      
      #non_numeric <- names(master$dataframe[unlist(lapply(master$dataframe, !is_ContinousNumeric))])
      
      categoricals <-names(master$dataframe)[!names(master$dataframe) %in% numbers] #because it could be factors or strings I just went for not numbers
      
      if(length(categoricals) < 1){
        categoricals = NULL
        categoricals_large = NULL
        categoricals_small = NULL
      }else{
        #find categorical variables with less than fifty unqiue values
        temp_names<-lapply(1:length(categoricals), function(x){
          temp_name<-categoricals[x]
          test<-nrow(unique(master$dataframe[temp_name]))
          if(test <= 50){categoricals[x]}
        })
        categoricals_large<-unlist(temp_names[!unlist(lapply(temp_names, is.null))])
        
        #find categorical variables with less than ten unqiue values
        temp_names<-lapply(1:length(categoricals), function(x){
          temp_name<-categoricals[x]
          test<-nrow(unique(master$dataframe[temp_name]))
          if(test <= 10){categoricals[x]}
        })
        categoricals_small<-unlist(temp_names[!unlist(lapply(temp_names, is.null))])
      }
      master$coltypes = list(
        numbers = numbers,
        categoricals = categoricals, #all categorical variables
        categoricals_large = categoricals_large, #only less than 50 categorical variables
        categoricals_small = categoricals_small #only less than 10 categorical variables
        
      )
      
    }
    datatable(master$dataframe,
              rownames =F,
              extensions = c("Scroller", 'Buttons'),
              style = "bootstrap" ,
              
              options = list(#dom ="tp",
                dom = 'rtip',
                deferRender = TRUE,
                scrollX = TRUE,
                pageLength = 40,
                scrollY = 500,
                scroller = TRUE)
    ) #the dom decides what parts of datatable are shown
    #https://datatables.net/reference/option/dom
  })
  
  
  observeEvent(input$file, {
    updateSelectInput(session,
                      inputId = "select_columns",
                      label = "Select predictor variables to fit model to:",
                      choices = names(master$dataframe),
                      selected = names(master$dataframe))
  })
  
  observeEvent(input$save, {
    master$date = Sys.time() #we use the time stamp to prioritize what to show
    master$dataframe = temp #we save the dataframe from the temp we saved to the global earlier to the view list
  })
  
  output$sample_warning<-renderUI({
    if(is.null(master$dataframe)){ #first make sure something is there
      return()
    }else{
      
      # if(nrow(master$dataframe) == input$samplesize ){
      #   div(class = "warning-box", HTML(paste0("<p style='color:#EE7600;'><i class='fas fa-exclamation-triangle'></i>To ensure high performance, this dashboad has taken a ",  input$samplesize, " row sample of the uploaded data.</p>")))
      # }else{
      #   return()
      # }
    }
  })
  

  



  
  # Describe Tab ------------------------------------------------------------
  
  
  # Predict Tab ------------------------------------------------------------

  # Predict Tab ------------------------------------------------------------
  source("server/predict/regression.R", local = T)
  source("server/predict/logistic_regression.R", local = T)

}

