

#creates custom download button with shopping cart icon instead of default download icon----------
customDownloadbutton <- function(outputId, label = " Download Workbook"){
  tags$a(id = outputId, class = "btn btn-custom shiny-download-link", href = "",
         target = "_blank", download = NA, icon = NULL, label,
         tags$i(id = "cart", class='fas fa-cart-arrow-down')
  )
}

# 5. results should include AIC and general the general regression summary



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
      
      menuItem("Welcome", tabName = "intro",icon=icon("bookmark")),
      menuItem("Data Entry", tabName = "collect",icon=icon("folder-open")),
      menuItem("Visualization",  tabName = "describe",icon=icon("cogs")),
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
              source("ui/dashboard.R")$value
      ),# end of intro tab
      
      # Collect Tab -------------------------------------------------------------
      
      tabItem(tabName = "collect",
      source("ui/collect_ui.R")$value       
      ), #end collect tab
      
      # Visualization Tab -------------------------------------------------------------
      ## The file to generate the visualization could be found on Final_Project_Deep_Sedation/Final project/final_plot_prototype_2.R on the Github page
      tabItem(tabName = "describe",
              img(src="Ethnicity_animation.gif", align = "center",height='500px',width='1000px')
      ), #end viz tab 
      
      tabItem(tabName = "predict",
              tabBox(width =NULL,
                     id = "predicttab",
                     tabPanel("What is Predict?",
                              class = "predictbg",
                              fluidRow(
                                column(width=9,
                                       HTML(landing$predict$body), id = "predictlandpad")
                              )),
                     tabPanel("Linear Regression",
                              source("ui/predict/regression_ui.R")$value  
                              ),
                     tabPanel("Logistic Regression",
                              source("ui/predict/logistic_ui.R")$value  
                     ),
                     tabPanel("Random Forest",
                              source("ui/predict/randomforest_ui.R")$value
                     ),
                     tabPanel("Forecast",
                              source("ui/predict/holtwinters_ui.R")$value
                              
                     )

                     
              ))#end of tab box
      
              
      
    ),
    
    #CSS style
    tags$head(tags$link(rel = 'stylesheet', type = 'text/css', href = 'bootstrap.css'))
  )

)

