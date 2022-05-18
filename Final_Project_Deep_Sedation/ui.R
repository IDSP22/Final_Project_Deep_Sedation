

#creates custom download button with shopping cart icon instead of default download icon----------
customDownloadbutton <- function(outputId, label = " Download Workbook"){
  tags$a(id = outputId, class = "btn btn-custom shiny-download-link", href = "",
         target = "_blank", download = NA, icon = NULL, label,
         tags$i(id = "cart", class='fas fa-cart-arrow-down')
  )
}

# 5. results should include AIC and general the general regression summary

# **Bonus**
#   This is completely optional but if you would like to make a more advanced app add the option to perform leave one out cross validation. 


dashboardPage(
  dashboardHeader(
    title = 'Critical Care: Patient Exposure to Deep Sedation',
    # Set height of dashboardHeader
    tags$li(class = "dropdown",
            tags$style(".main-header .navbar {margin-left: 800px;}"),
            tags$style( ".main-header .logo {width: 800px;}")
    )
  ),
  dashboardSidebar(
    # hides sidebar toggle "hamburger" icon
    tags$script(JS("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")),
    #tags$style(HTML(".main-sidebar{width: 300px; }")),
    sidebarMenu(
      
      menuItem("Intro", tabName = "intro",icon=icon("bookmark")),
      menuItem("Collect", tabName = "collect",icon=icon("folder-open")),
      menuItem("Describe",  tabName = "describe",icon=icon("clipboard")),
      menuItem("Predict",  tabName = "predict", icon=icon("chart-line"))
    ),
 
column(12,div(HTML("<hr>"), align = "center")),
 
 div(customDownloadbutton("workbookDownload"), tags$div(id = 'placeholder', align = "right"),
     align = "center")
 
  ),
  dashboardBody(
    tags$head(tags$link(rel = "icon", type = "image/jpg", href = "brain_network.jpg"),
              tags$title('Critical Care: Patient Exposure to Deep Sedation')
      ),
    tabItems(
      
      # Intro Tab ---------------------------------------------------------------
      
      tabItem(tabName="intro",
              class = "introbg"
      ),# end of intro tab
      
      # Collect Tab -------------------------------------------------------------
      
      tabItem(tabName = "collect",
      source("ui/collect_ui.R")$value       
      ), #end collect tab
      
      tabItem(tabName = "predict",
              tabBox(width =NULL,
                     id = "predicttab",
                     tabPanel("What is Predict?",
                              class = "predictbg"),
                     
                     tabPanel("Linear Regression"
                              )

                     
              )),#end of tab box
        
      # Visualization Tab -------------------------------------------------------------
              
       tabItem(tabName = "viz",
       img(src="Ethnicity_animation.gif", align = "center",height='500px',width='1000px')
              ) #end viz tab   
              
      
    ),
    
    #CSS style
    tags$head(tags$link(rel = 'stylesheet', type = 'text/css', href = 'bootstrap.css'))
  )

)

