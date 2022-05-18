#### Regression section
observe({
  if(!is.null(master$train)){
    #remove categorical variables with more than 50 unique values from possible selection
    x <- names(master$train[unlist(lapply(master$train, is.numeric))])

    updatePickerInput(session,
                      "regress_pred",
                      "Select predictor variables to fit model to:",
                      choices = x,
                      choicesOpt = list(
                          `actions-box` = TRUE,
                          size = 10,
                          selected = x[1]
                )
    )

    #pickerInput(
     # inputId = "myPicker",
     # label = "Select/deselect all + format selected",
      #choices = LETTERS,
     # options = list(
       # `actions-box` = TRUE,
       # size = 10,
       # `selected-text-format` = "count > 3"
     # ),
     # multiple = TRUE
 #   )

    updateSelectInput(session,
                      inputId = "regress_response",
                      label = "Select response variable:",
                      choices = x,
                      selected = x[2]
    )

  }
})

observe({
  # user has selected an option for predictor and response
  if (length(input$regress_pred) > 0 && length(input$regress_response) > 0){
    # if the response is in the predictors than disable and create warning
    if ((input$regress_response) %in% (input$regress_pred)){
                disable("run_regress") # disable
                html_helpers$lin_reg_trigger = TRUE # create warning
        # ELSE if the the reponse ISNT in the predictors...
        }else{
          html_helpers$lin_reg_trigger = FALSE # turn off warning
          enable("run_regress") # enable button
           }
    # ELSE If the users hasnt selected a response and predictor
    }else{
    html_helpers$lin_reg_trigger = FALSE # turn off warning --probably will never happen
    disable("run_regress") # disable button
  }

})

#This generates a warning if the predictor variable is the same as the response variable.
#
# observe({
#   if ( length(input$regress_pred) > 0 && length(input$regress_response) > 0 ) {
#     if ((input$regress_pred) == (input$regress_response) ) {
#     disable("run_regress")
#       html_helpers$lin_reg_trigger = TRUE
#     }
#   } else {
#     print("doublecheck")
#     enable("run_regress")
#     html_helpers$lin_reg_trigger = FALSE
#
#   }
# })



#  }
#})

#observe({
# if ( length(input$regress_pred) > 0 && length(input$regress_response) > 0 ) {
#    if ( (input$regress_pred) != (input$regress_response) ) {
#      html_helpers$lin_reg_trigger = FALSE
#    } else {
#      html_helpers$lin_reg_trigger = TRUE
#    }
#  }
#  })
# observe({
#   if ( length(input$regress_pred) > 0 && length(input$regress_response) > 0 ) {
#     if ( (input$regress_pred) != (input$regress_response) ) {
#       html_helpers$lin_reg_trigger = FALSE
#     } else {
#       html_helpers$lin_reg_trigger = TRUE
#     }
#   }
#   })

#regression results saved to reactive value. plot and results wont appear without it
observeEvent(input$run_regress, {

  if(is.null(master$train)){
    return()
  }else{

  df<-master$train
  #performing regression and getting results
  regression<-lm(paste0(input$regress_response, "~", paste(input$regress_pred, collapse = "+")), df)
  coeftable <- as.data.frame(tidy(regression)) #using broom, lets get results as a df
  regress_goodness <-as.data.frame(glance(regression))
  #creating an easy to work with coeftable
  full_table<-coeftable%>% select("Term" = term, "Coefficient" = estimate,
                                  "Standard Error"= std.error, "P Value" = p.value) #save a full table to use in the results

  coefficient_cells = paste0("B", paste(5:(3+nrow(full_table))))

  #for the formula table, we only need to the independent variable. This is hard coded for now

  #take the mean of each of the indie vars for the default value for the formula
  indie_vars = lapply(master$train[,c(input$regress_pred)], function(x){
    mean(x)
  })%>%unlist()%>%as.data.frame()

  #cleaning indie vars
  indie_vars$vars <- row.names(indie_vars) #row names as var
  names(indie_vars) = c("values", "vars") #renaming, because "." is the default name, we cant do this in the next line
  indie_vars = indie_vars %>% select(vars, values) # reordering
  formula_table = rbind(c(full_table[1,1], full_table[1,2]), indie_vars) #putting the intercept on top

  #this depends on both the starting column and the starting row
  value_cells = paste0("G", paste(10:(8+nrow(formula_table))))

  #combine the coefficients and values and seperate them by *, then collapse them by +
  regress_formula = paste0("B4 +", paste(paste(coefficient_cells, value_cells, sep = "*"), collapse = " + "))


  coeftable<-coeftable[2:nrow(coeftable),]
  #coeftable<-coeftable%>%filter(!is.na(p))
  rownames(coeftable) <- NULL

  #variable reporting selection

  #are there any signficant variables
  if(min(coeftable[,5]) < .05){
    #finding out of the relevant variables, which has the largest effects
    coeftable<-coeftable
    rel_vars<-coeftable%>%filter(p.value < .05)%>%
      arrange(desc(estimate))
    to_describe<-rel_vars[1,]
    #describing the results. we only look at the variables with the p values under .05
    #we only describe the value with the biggest effect
    describe_text <- paste0("<font size = 3> <strong> Summary of Results </font> </strong> <br>
                            The following variables had a statistically significant result: ", paste(rel_vars[,1], collapse = ", "), ".<br><br>",
                            "Of these variables, ", to_describe[1,1], " had the largest effect. ", "For every one unit increase of ", to_describe[1,1],
                            " there is a predicted ", round(to_describe[1,2], 3), " change in ", tolower(input$regress_response), ". <br> The p-value of ", to_describe[1,1], " is ", round(to_describe[1,5], 5), " meaning that there is a ",
                            round(to_describe[1,5], 3)*100, "% chance that there is no relationship between the two variables.")
  }else{
    #if there are no relevant variables, which has the lowest p value.
    coeftable<-coeftable%>%arrange(p.value)
    to_describe <- coeftable[1,]

    #describing the results. we only look at the variable with the lowest p value
    describe_text <- paste0("<font size = 3> <strong> Summary of Results </font> </strong> <br>
                            None of the predictor variables had a stastically signifcant
                            effect on ", input$regress_response, ". As a result, NimbleDash will provide the effect of the predictor variable
                            with the lowest p-value, which has the lowest chance of being irrelevant to the results.<br><br>",
                            "The p-value of ", to_describe[1,1], " is ", round(to_describe[1,5], 5), " meaning that there is a ",
                            round(to_describe[1,5], 3)*100, "% chance that there is no relationship between the two variables.",

                            "For every one unit increase of ", to_describe[1,1], " there is a predicted ", round(to_describe[1,2],3), " change in ",
                            tolower(input$regress_response), ". ")
  }

  general_text <- paste0("The model has an R Squared of ", round(regress_goodness$r.squared,3), ". This means that ", 100*(round(regress_goodness$r.squared, 4)),
                         "% of the variation of the data is explained by the model.")

  df<-master$train #easier to write code outside of a list

  #makes sure there is something to plot
  if(is.null(df)){
    return()
  }else{

    #cleaning up data for plotting
    df <- df[!is.na(df[,input$regress_pred]),] #wont plot unless there are no nulls :(
    df <- df[!is.na(df[,input$regress_response]),]

    #taking a random sample to improve speed if the dataframe is larger than 2000 rows
    if(nrow(df)>2000){
      df<-df[sample(nrow(df), 2000),]}

    #creating axis titles
    x <- list(
      title = to_describe[1,1],
      showgrid = F,
      titlefont = plot_font,
      tickfont = plot_font
    )

    y <- list(
      title = paste0(input$regress_response),
      showgrid = F,
      titlefont = plot_font,
      tickfont = plot_font,
      tickformat = ","
    )

    #finally the plot
    regress_plot<-plot_ly(alpha = .6, x = df[, as.character(to_describe[1,1])])%>%
      add_trace(y = df[,input$regress_response])%>%
      #the y value is the fitted regression results from the dataframe so number of rows match.
      add_lines(x = df[, as.character(to_describe[1,1])], y = fitted(lm(df[,input$regress_response]~df[,as.character(to_describe[1,1])], df)))%>%
      config(plot_ly(), displaylogo = FALSE, modeBarButtonsToRemove = list('lasso2d', 'zoom2d'))%>%
      layout(separators = ".,", yaxis = y, xaxis= x, showlegend =F) %>% config(displayModeBar = 'hover')

  }
  regress_goodness<- as.data.frame(t(regress_goodness[,1:2]))
  regress_goodness$V2 <- row.names(regress_goodness)
  regress_goodness= regress_goodness%>%select("Metric" = V2, "Value" = V1)


  regression_results<-list(

    final_text = paste0(describe_text, general_text),
    regress_table = full_table,
    regress_plot= regress_plot,
    regress_goodness = regress_goodness,
    regress_formula = regress_formula,
    formula_table = formula_table,
    fit = regression
  )

  master$model_regress<-regression_results
  }
})

#this is the text that explains the results of the regression

output$regression_results<- renderUI({
  if(is.null(master$model_regress$final_text)){
    return()
  }else{
    HTML(master$model_regress$final_text)
  }
})


#regression plot
output$regression_plot <- renderPlotly({
  if(is.null(master$model_regress$regress_plot)){
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

    master$model_regress$regress_plot
  }

})
output$regress_table_title<-renderUI({
  if(is.null(master$model_regress$regress_table)){
    return()
  }else{
    HTML("<font size = 3> <strong> Econometric Table </font> </strong> <br>")
  }
})
# output$regression_toggle1<-renderUI({
#   if(is.null(master$model_regress$regress_table)){
#     return()
#   }else{
#   div(id= "what_reg", class = "what_button_init",
#     h4(id= "regression_toggle", class = "toggle_init", HTML("<i class='far fa-question-circle'></i> Whats This?")),
#     hidden(div(id = "regression_description", HTML(descriptions$regression)))
#   )
#   }
# })

#econometrics table
output$regression_table <- renderDataTable({
  if(is.null(master$model_regress$regress_table)){
    return()
  }else{
    datatable(master$model_regress$regress_table,
              #colnames = c("Coefficients", "Standard Errors", "p-values"),
              options = list(dom ="t"))
  }
})

linregid = 0
observeEvent(input$add_regress, {
  master$counter = master$counter + 1
  df <- master$model_regress$regress_table #less to type

  # #if they click the button twice this will delete whats there so the app doesnt crash
  # if("Linear Regression" %in% wb$sheet_names){
  #   removeWorksheet(wb, "Linear Regression")
  # }

  if (linregid == 0) {
    wb_name <- paste("Linear Regression")
  } else {
    wb_name <- paste("Linear Regression", linregid, sep = "-")
  }

  addWorksheet(wb, wb_name)

  #adding title for report
  writeData(wb, wb_name, paste0("Regression Report ", Sys.Date()), startRow =1 )
  addStyle(wb, wb_name, styles$big_style, rows = 1, cols= 1)

  #econometric output table
  writeData(wb, wb_name, "Econometrics Output", startRow =2)
  addStyle(wb, wb_name, styles$title_style, rows = 2, cols= 1)
  writeData(wb, wb_name, df, startRow = 3)
  addStyle(wb, wb_name, styles$row_style, rows = 3, cols = 1:4, gridExpand = T)
  addStyle(wb, wb_name, styles$all_style, rows = 4:(4+(nrow(df)-1)), cols = 1:4, gridExpand = T)

  #adding goodness of fits metrics
  writeData(wb, wb_name, "Goodness of Fit Metrics", startRow =2, startCol = 6)
  addStyle(wb, wb_name, styles$title_style, rows = 2, cols= 6)
  writeData(wb, wb_name, master$model_regress$regress_goodness, startRow = 3, startCol = 6)
  addStyle(wb, wb_name, styles$row_style, rows = 3, cols = 6:7, gridExpand = T)
  addStyle(wb, wb_name, styles$all_style, rows = 4:5, cols = 6:7, gridExpand = T)

  #adding interactive formula table
  writeData(wb, wb_name, "Interactive Formula Table", startRow =7, startCol = 6)
  addStyle(wb, wb_name, styles$title_style, rows = 7, cols= 6)
  writeData(wb, wb_name, master$model_regress$formula_table, startRow = 8, startCol = 6)
  addStyle(wb, wb_name, styles$row_style, rows = 8, cols = 6:7, gridExpand = T)
  addStyle(wb, wb_name, styles$all_style, rows = 9:(8+nrow(master$model_regress$formula_table)), cols = 6:7, gridExpand = T)
  writeData(wb, wb_name, "Estimate", startCol = 6, startRow = 9+nrow(master$model_regress$formula_table))
  writeFormula(wb, wb_name, master$model_regress$regress_formula, startCol = 7, startRow = 9+nrow(master$model_regress$formula_table))
  addStyle(wb, wb_name, styles$total_style, rows = 9+nrow(master$model_regress$formula_table), cols = 6:7, gridExpand = T)

  linregid <<- linregid + 1

})

output$regress_download<- renderUI({
  if(is.null(master$model_regress$regress_table)){
    return()
  }else{
    actionButton("add_regress", "Add Results to Your Workbook")
  }
})


observe({
  callModule(whats_this, #calling the module
             "regression", #creating the name space
             "Predict Linear Relationships with Regression", #this is used to check if the model is there
             descriptions$regression #the description to be passed to the div
  )
})

output$input_ui <- renderUI({
  if(is.null(master$model_regress)){
    return()
  }else{

    regress_pred <- isolate({input$regress_pred})

    num <- as.integer(length(regress_pred)) # how many inputs are we making
    pred_nam <- regress_pred

    div(
      class = "pred_input",
        fluidRow(
        lapply(1:num, function(i) {
          column(2,
          numericInput(paste0(pred_nam[i]), label = paste0(pred_nam[i]), value = 0)
          )
              })
                )
    #paste0(pred$reg)

    )
  }
})

output$table <- renderTable({

if(is.null(master$model_regress)){
  return()
}else{

  regress_pred <- isolate({input$regress_pred})
  regress_response <- isolate({input$regress_response})

  num <- as.integer(length(regress_pred))
  pred_nam <- regress_pred

  newdata = data.frame(lapply(1:num, function(i) {

    as.numeric(input[[pred_nam[i]]])
    }))
  names(newdata) <- pred_nam
  prediction = predict(master$model_regress$fit, newdata)%>%as.data.frame()
  names(prediction) <- paste(regress_response)
  #pred$reg <- prediction[1,1]
  prediction
}
  })


#Generates warning if predictor variable is same as response variable.

observe({

  callModule(warning, #call the module
             "linregwarn", #create the namespace
             html_helpers$lin_reg_trigger, #when the warning message should be shown
             warnings$linregwarn) # the warning itself

})
