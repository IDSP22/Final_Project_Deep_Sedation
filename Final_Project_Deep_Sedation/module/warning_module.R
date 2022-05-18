### warning module

warningUI <- function(id){
  ns <- NS(id)
  uiOutput(ns("warning"))
}

warning <- function(input, output, session, trigger, text){
  print(trigger)
  
  output$warning<-renderUI({  
      if(trigger == F){
        return()
      }else{

        div(class = "warning-box", 
            HTML(text))
      }
        })
  

}