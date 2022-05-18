whats_thisUI <- function(id){
  ns <- NS(id)

    uiOutput(ns("toggle1"))

}

whats_this <- function(input, output, session, title, description){
  
output$toggle1<-renderUI({

    div(
      
      fluidRow(
        column(6,
               h4(title)), # this is the title
        
        column(6,
               h5(id= session$ns("toggle"), #class = "toggle_init", 
                  HTML("<i class='far fa-question-circle'></i> What's This?")), id="wt-rightalign"
        ), class="wt-row"),
      
      
      fluidRow(
        column(12,
               #div(id= session$ns("what"), class = "what_button_init", 
               hidden(div(id = session$ns("description"), HTML(description)))
               #)
        ))
    )
      
    
      
})

#we want to switch a bunch of classes when the user clicks the whats this button
onclick("toggle", toggle("description")) #this makes the text show up

#these two switch the div, the first one is the div on initialzation. the second after the user clicks
#they toggle, so if the user clicks again it goes back to the init
onclick("what", toggleClass("what", "what_button_init"), add =TRUE)
onclick("what", toggleClass("what", "what_button_clicked"), add =TRUE)

#these two switch the text of the toggle, the first one is the div on initialzation. the second after the user clicks
#they toggle, so if the user clicks again it goes back to the init
onclick("what", toggleClass("toggle", "toggle_init"), add =TRUE)
onclick("what", toggleClass("toggle", "toggle_clicked"), add =TRUE)
onevent("hover", "toggle", toggleClass("toggle", "toggle_hover"), add =TRUE)


}