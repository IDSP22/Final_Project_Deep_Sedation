# we will init the openxlsx object here

# create workbook on loading app
wb <- createWorkbook()

# we created a counter in the global as a reactive value
# each time a add to workbook is clicked the counter is increased by 1
# this observe event watchs the counter and reruns each time it changes
observe({

  # m is the current value of the counter
  m = master$counter

  # remove an element with id of "test"
  removeUI(
      selector = '#test',
      multiple = F
    )

  # if the master counter is above 0, it will create a dot with the value of the
  # counter inside of it
  if(master$counter > 0){
      insertUI(
        selector = '#placeholder',
        ## wrap element in a div with id for ease of removal
        ui = tags$div(
          id="test",
          tags$p(paste(m)),
          tags$span(id = 'dot', class = 'dot'),
          n = m
        )
      )
    }

})


# we are going to do a bunch of functions when download handler is used
output$workbookDownload <- downloadHandler(

  filename = function() {
    paste("Report-", Sys.Date(), ".xlsx", sep="")
  },

  # function(file) is a reactive context so we can put functions here
  content = function(file) {

    # first we remove the red dot
    removeUI(
      selector = '#test',
      multiple = F
    )

    # then we reset the counter
    master$counter = 0

    # we download the file
    saveWorkbook(wb, file)
    # we delete the file
    rm(wb)
    # and then we recreate it
    wb <<- createWorkbook()
  }
)
