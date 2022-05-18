function(input, output, session){
  
  rv <- reactiveValues(download_flag = 0)
  
  
  # as a function of loading in data, the collect tab cannot be sourced. its very small though
  # Collect Tab -------------------------------------------------------------
  source("server/downloadworkbook.R", local=T)
  
  
  
  filedata <- reactive({
    infile <- input$file
    if (is.null(infile)) {
      # User has not uploaded a file yet
      return(NULL)
    }
    fread(infile$datapath, check.names = T, data.table = F, nrows = input$samplesize)
    #read.csv.sql(infile$datapath, sql = "select * from file order by random() limit 10000")
    #switched to the data.table read in as it is much quicker
  })
  
  #on the first tab we manipulate the data and save it for use in the other tabs
  output$tab1 <- renderDataTable({
    
    master$dataframe <- filedata()
    
    sample <- sample.int(n = nrow(master$dataframe), size = floor(.75*nrow(master$dataframe)), replace = F)
    master$train <- master$dataframe[sample, ]
    master$test  <- master$dataframe[-sample, ]
    
    temp <<- master$dataframe
    
    #to reduce code, creating a list of commonly used coltypes
    
    if(!is.null(master$dataframe)){
      numbers <- names(master$dataframe[unlist(lapply(master$dataframe, is.numeric))])
      
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
              filter='top',
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


  # Validate Tab ------------------------------------------------------------

}

