library(shiny)
library(leaflet)
library(tidyverse)


ui <- fluidPage(
  
  # App title ----
  titlePanel("College Match: SAT and GPA"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      # Input: SAT Slider 
      sliderInput("n",
                  "SAT Score",
                  value = 1250,
                  min = 0,
                  max = 1600, 
                  step = 10),
      
      tableOutput(IPEDS_data_2),
      
      
      # Input: GPA Slider 
      sliderInput("n",
                  "GPA (unweighted)",
                  value = 3.5,
                  min = 0,
                  max = 4, 
                  step = 0.01)
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Search by Your Stats",
                     numericInput(
                         inputId = "statsInput",
                         label = "Enter SAT to see compatible schools",
                         value = "0",
                         min = "0",
                         max = "1600",
                         step= 10),

                     actionButton("submit","Submit Score", icon("submit"), width = NULL),
                    

                           DT::dataTableOutput("schooltable")
                        ),
                  
                 tabPanel("Search by Colleges",
                           selectizeInput(
                             inputId = "schoolinput", 
                             label = "Search by School", 
                             IPEDS_data_2$Name, 
                             multiple = FALSE 
                             ),
                           
                           
                           leafletOutput("search_by_map")
                  
                          ),
      
      
                  tabPanel("Compare Colleges", 
                           selectizeInput('compareinput1', 'School 1', IPEDS_data_2$Name, multiple=FALSE), 
                
                           selectizeInput('compareinput2', 'School 2', IPEDS_data_2$Name, multiple=FALSE),
                      
                           selectizeInput('compareinput3', 'School 3', IPEDS_data_2$Name, multiple=FALSE),
                         
                           selectizeInput('compareinput4', 'School 4', IPEDS_data_2$Name, multiple=FALSE),
                          
                           selectizeInput('compareinput5', 'School 5', IPEDS_data_2$Name, multiple=FALSE),
                           
                           actionButton("goButton", "Compare"),

                           
                           plotOutput("plot", height = 300,
                                      click = clickOpts(id = "plot_click"),
                                      hover = hoverOpts(id = "plot_hover", delayType = "throttle"),
                                            ),
                                      
                                  h4("Clicked points"),
                                  tableOutput("plot_clickedpoints")
                                  )
                             
        )
      )
    ))

   
                          
                         
    
