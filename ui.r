library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)


ui <- fluidPage(
  
  # App title ----
  titlePanel("College Match: SAT Score"),
    
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
                  

        tabPanel("Explore",
                selectizeInput("searchschool", 
                  "Explore by School", 
                  choices = as.list(IPEDS_data_2$Name), 
                  multiple = FALSE),
                             
                DT::dataTableOutput("searchtable"), 
                
                #leafletOutput("map"),
                
                fluidRow(
                  column(6, 
                         selectInput(
                           inputId = "explorestate",
                           label = "Explore by State", 
                           choices = IPEDS_data_2$`State abbreviation`,
                           multiple = FALSE)
                  ), 
                  column(6, 
                         selectInput(
                           inputId = "exploreregion", 
                           label = "Explore by Region", 
                           choices = as.list(IPEDS_data_2$`Geographic region`),
                           multiple = FALSE)
                  )
                ),
                
                #fluidRow(
                  #column(8, 
                         #plotOutput("stateenrollment")
                  #), 
                  #column(8,
                         #plotOutput("regionenrollment")
                  #)
                #),
                
                fluidRow(
                  column(6, 
                         plotOutput("statesat25th")
                  ), 
                  column(6,
                         plotOutput("regionsat25th")
                  )
                ), 
                
                fluidRow(
                  column(6, 
                         plotOutput("statesat75th")
                  ), 
                  column(6,
                         plotOutput("regionsat75th")
                  )
                ),
                
                fluidRow(
                  column(6, 
                         plotOutput("statetuition")
                  ), 
                  column(6,
                         plotOutput("regiontuition")
                  )
                )
        ),            

      
      
                  tabPanel("Compare Colleges", 
                         
                              selectizeInput('compareinput1', 'School 1', IPEDS_data_2$Name, multiple=FALSE), 
                
                              selectizeInput('compareinput2', 'School 2', IPEDS_data_2$Name, multiple=FALSE),
                      
                              selectizeInput('compareinput3', 'School 3', IPEDS_data_2$Name, multiple=FALSE),
                         
                              selectizeInput('compareinput4', 'School 4', IPEDS_data_2$Name, multiple=FALSE),

                              selectizeInput('compareinput5', 'School 5', IPEDS_data_2$Name, multiple=FALSE),
  
                                actionButton("goButton", "Compare"),

                           
                        plotOutput('selectInput'),
                           
                           plotOutput("plot", height = 300,
                                      click = clickOpts(id = "plot_click"),
                                      hover = hoverOpts(id = "plot_hover", delayType = "throttle"),
                                            ),
                                      
                                  h4("Clicked points"),
                                  tableOutput("plot_clickedpoints"),

                              selectizeInput('compareinput5', 'School 5', IPEDS_data_2$Name, multiple=FALSE),
                           
                              actionButton("goButton", "Compare"),
                              
                  plotOutput("comparecolleges", width = "100%", height = "400px",
                            click = clickOpts(id = "plot_clickedpoints", clip = TRUE),
                            
                  fluidRow(column
                           (width = 6, h4("Points Selected"),
                            verbatimTextOutput("click_info")
                           )
                  )            
       
                  )
                  )
      )
    )
)

