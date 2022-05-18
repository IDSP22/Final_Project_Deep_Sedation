observe({
  if(!is.null(master$dataframe)){

    
    # x <-c(master$coltypes$numbers, master$coltypes$categoricals_large)
    
    # Must be quant vars?
    updatePickerInput(session,
                      "multinom_pred",
                      "Select predictor variables to fit model to:",
                      choices = master$coltypes$numbers,
                      choicesOpt = list(
                        `actions-box` = TRUE,
                        size = 10,
                        selected = NULL
                      )
    )
    
     # updateSelectInput(session,
     #                  inputId = "multinom_pred",
     #                  choices = master$coltypes$numbers,
     #                  selected = NULL)
    
    # Must be categorical vars
    updateSelectInput(session, 
                      inputId = "multinom_response",
                      choices = master$coltypes$categoricals_small,
                      selected = NULL)
  }
})

# Makes sure there is an input in predictor and response variable inputs
observe({

      if (is.null(input$multinom_pred) || 
          length(input$multinom_pred)==0 || 
          is.null(input$multinom_response) || 
          length(input$multinom_response)==0
          )
    {
    disable("fit_multinom")
  } else {
    enable("fit_multinom")
  }
})

observeEvent(input$fit_multinom, {
  if(length(unique(master$dataframe[,input$multinom_pred]))< 3){
    print("test")
    return()
  }
  set.seed(1)
  multinom_model = nnet::multinom(as.formula(paste(input$multinom_response, paste(input$multinom_pred, collapse="+"), sep="~")),
                                  data = master$dataframe,
                                  trace=FALSE)

  multinom_results<<-list(
    model = multinom_model,
    coefficients_table = round(exp(summary(multinom_model)$coefficients)/(1+exp(summary(multinom_model)$coefficients)), 3),
    standard_errors_table = round(summary(multinom_model)$standard.errors, 3),
    z_values_table = round(summary(multinom_model)$coefficients/summary(multinom_model)$standard.errors, 3),
    p_values_table = round((1 - pnorm(abs(summary(multinom_model)$coefficients/summary(multinom_model)$standard.errors), 0, 1))*2, 3), # we are using two-tailed z test
    describe_text = NULL
    )
  
  # Add pred var with lowest mean p-value as the var to visualize
  if (length(input$multinom_pred) > 1){
    

      master$model_multinom$pval_preds <- data.frame(multinom_results$p_values_table[,2:ncol(multinom_results$p_values_table)] %>% colMeans)
    
    multinom_results$multinom_viz_xvar <- rownames(master$model_multinom$pval_preds)[which(master$model_multinom$pval_preds[,1]==min(master$model_multinom$pval_preds[,1], na.rm = TRUE))[1]]
  } else{
    multinom_results$multinom_viz_xvar <- input$multinom_pred[1]
  }

  
  master$model_multinom <- multinom_results
  })


output$multinom_plot <- renderPlotly({
  
  #makes sure there is something to plot
  if(is.null(master$dataframe)||
     is.null(master$model_multinom$model) ||
     is.null(input$multinom_response) ||
     (input$multinom_response=="")){ 
    return()
  }else{
    
    # Create 0-row data frame which will be used to store data
    dat <- data.frame(x = numeric(0), y = numeric(0))
    #
    withProgress(message = 'Making plot', value = 0, {
      #   # Number of times we'll go through the loop
      n <- 10
      #
      for (i in 1:n) {
        #     # Each time through the loop, add another row of data. This is
        #     # a stand-in for a long-running computation.
        dat <- rbind(dat, data.frame(x = rnorm(1), y = rnorm(1)))
        #
        #     # Increment the progress bar, and update the detail text.
        incProgress(1/n)
        #
        #     # Pause for 0.1 seconds to simulate a long computation.
        Sys.sleep(0.1)
      }
    })
    

    var1.grid <- seq(min(master$dataframe[,master$model_multinom$multinom_viz_xvar], na.rm = TRUE), max(master$dataframe[,master$model_multinom$multinom_viz_xvar], na.rm = TRUE), length.out = 50)
    plot_line_data = data.frame(var1_line=var1.grid)

    for (i in master$model_multinom$model$coefnames[2:length(master$model_multinom$model$coefnames)]){
      # If var is not intercept or visualization var, add var's mean to df
      if (!((i == "(Intercept)") || (i == master$model_multinom$multinom_viz_xvar))){
        plot_line_data = cbind.data.frame(plot_line_data, rep(mean(master$dataframe[[i]], na.rm=TRUE), nrow(plot_line_data)))
        names(plot_line_data)[length(names(plot_line_data))] <- i
      }
    }

    names(plot_line_data)[1] = master$model_multinom$multinom_viz_xvar

    log_reg_pred <- cbind.data.frame(plot_line_data[,1], predict(master$model_multinom$model, newdata = plot_line_data, type="probs"))
    names(log_reg_pred)[1] = master$model_multinom$multinom_viz_xvar
    
    if (min(master$model_multinom$pval_preds, na.rm = TRUE) <= .05){
      stat_sig_vars <- rownames(master$model_multinom$pval_preds)[(master$model_multinom$pval_preds<=.05)]
      
      description <- paste0("<font size = 3> <strong> Summary of Results </font> </strong> <br>
                            The following variables had a statistically significant result: ", paste(stat_sig_vars, collapse = ", "), ".<br><br>",
                            "Of these variables, ", master$model_multinom$multinom_viz_xvar, " had the largest effect.<br>")
      
      for (row in rownames(master$model_multinom$coefficients_table)){
        description <- c(description,
                         paste0("A one unit increase in ",
                                master$model_multinom$multinom_viz_xvar,
                                " increases the probability of ",
                                input$multinom_response,
                                " being classified as ",
                                row,
                                " relative to ",
                                master$model_multinom$model$lev[1],
                                " by ",
                                master$model_multinom$coefficients_table[row,master$model_multinom$multinom_viz_xvar]*100,
                                "%"))
      }
     
      description <- paste(description, collapse="<br>")
      
      master$model_multinom$describe_text <- description
    } else {
      #if there are no relevant variables, which has the lowest p value.
      
      description <- paste0("<font size = 3> <strong> Summary of Results </font> </strong> <br>
                            None of the predictor variables had a stastically signifcant 
                            effect on ", input$multinom_response, ". As a result, Nimble will provide the effect of the predictor variable
                            with the lowest p-value: ", master$model_multinom$multinom_viz_xvar, ". 
                          This has the lowest chance of being irrelevant to the results.<br>")
      
       for (row in rownames(master$model_multinom$coefficients_table)){
         description <- c(description,
                               paste0("A one unit increase in ",
                                      master$model_multinom$multinom_viz_xvar,
                                      " increases the probability of ",
                                      input$multinom_response,
                                      " being classified as ",
                                      row,
                                      " relative to ",
                                      master$model_multinom$model$lev[1],
                                      " by ",
                                      master$model_multinom$coefficients_table[row,master$model_multinom$multinom_viz_xvar]*100,
                                      "%"))
       }

      description <- paste(description, collapse="<br>")
      
      master$model_multinom$describe_text <- description
      
      
    }

    logitPlot <- plot_ly(x=log_reg_pred[,1], y = log_reg_pred[,2], name = names(log_reg_pred)[2], type = 'scatter', mode = 'lines')
    
    for (i in 3:ncol(log_reg_pred)){
      logitPlot <- logitPlot %>% add_trace(y = log_reg_pred[,i], name = names(log_reg_pred)[i], type = 'scatter', mode = 'lines')
    }
    
    logitPlot <- logitPlot %>%
      config(plot_ly(), displaylogo = FALSE, modeBarButtonsToRemove = list('zoom2d'))%>%
      layout(title=paste("Probability of", input$multinom_response, "classification versus", master$model_multinom$multinom_viz_xvar),
             separators = ".,",
             xaxis = list(title = master$model_multinom$multinom_viz_xvar),
             yaxis = list(title = paste("Probability of", input$multinom_response, "Classification")),
             showlegend = T)
    
    logitPlot
  }
})



# Create titles for Model Summary Tables
output$multinom_model_summary_title<-renderUI({
  if(is.null(master$model_multinom)){
    return()
  }else{
    HTML("<font size = 4> <strong> Model Summary </font> </strong> <br>")
  }
})

output$multinom_model_summary_note<-renderUI({
  if(is.null(master$model_multinom)){
    return()
  }else{
    HTML(paste0("<font size = 3> ", "Note: The reference class for the following tables is ", master$model_multinom$model$lev[1], " </font> <br>"))
  }
})

output$multinom_coefficients_title<-renderUI({
  if(is.null(master$model_multinom)){
    return()
  }else{
    HTML("<font size = 3> <strong> Coefficients (Probability) </font> </strong> <br>")
  }
})

output$multinom_coefficient_standard_errors_title<-renderUI({
  if(is.null(master$model_multinom)){
    return()
  }else{
    HTML("<font size = 3> <strong> Coefficient Standard Errors </font> </strong> <br>")
  }
})

output$multinom_coefficient_p_values_title<-renderUI({
  if(is.null(master$model_multinom)){
    return()
  }else{
    HTML("<font size = 3> <strong> Coefficient p-values </font> </strong> <br>")
  }
})

# Create data tables for Model Summary tables
output$multinom_coefficients_table <- renderDataTable({
  if(is.null(master$model_multinom)){
    return()
  }else{
    datatable(master$model_multinom$coefficients_table,
              options = list(dom ="t"))
  }
})

output$multinom_coefficient_standard_errors_table <- renderDataTable({
  if(is.null(master$model_multinom)){
    return()
  }else{
    datatable(master$model_multinom$standard_errors_table,
              options = list(dom ="t"))
  }
})

output$multinom_coefficient_p_values_table <- renderDataTable({
  if(is.null(master$model_multinom)){
    return()
  }else{
    datatable(master$model_multinom$p_values_table,
              options = list(dom ="t"))
  }
})

# Describe text at top
output$multinom_describe_text <- renderUI({
  if(is.null(master$dataframe)||
      is.null(master$model_multinom$model) ||
      is.null(input$multinom_response) ||
      (input$multinom_response=="")){
    return()
  }else{
    HTML(master$model_multinom$describe_text)
  }
})

output$logistic_regression_toggle1<-renderUI({
  if(is.null(master$model_multinom)){
    return()
  }else{
    div(class = "landingpage_side", 
        h4(id= "logistic_regression_toggle", HTML("<i class='far fa-question-circle'></i> Whats This?")),
        hidden(div(id = "logistic_regression_description", HTML(descriptions$logistic_regression)))
    )
    }
})

onclick("logistic_regression_toggle", toggle("logistic_regression_description"))

#on click event via shinyjs
observe({
  callModule(whats_this, #calling the module
             "logit_description", #creating the name space
             "Predict Categories with Logistic Regression", #this is used to check if the model is there
             descriptions$logistic_regression #the description to be passed to the div
  )
})