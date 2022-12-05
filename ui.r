library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)


ui <- fluidPage(
  
  # App title ----
  titlePanel("College Match: SAT and GPA"),
    
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Search by Your Stats"),
                     numericInput("statsinput",
                         "Enter SAT",
                          value = "0",
                          min = "0",
                          max = "1600",
                          step = 10),
                     
                     actionButton("submit","Submit Score", icon("submit"), width = NULL),
                    
                     tableOutput("schoolTable")
                      ),
                        "statsInput",
                        "Enter SAT to see compatible schools",
                         value = "0",
                         min = "0",
                         max = "1600",
                         step= 10),

                     actionButton("submit","Submit Score", icon("submit"), width = NULL),
                    

                           DT::dataTableOutput("schooltable")
                        )
                  

         tabPanel("Explore",
                           selectizeInput("searchschool", 
                                          "Explore by School", 
                                          choices = as.list(IPEDS_data_2$Name), 
                                          multiple = FALSE),
                             
                           DT::dataTableOutput("searchtable"), 
                
                           leafletOutput("map"),
                
                           selectInput(
                             inputId = "explorestate",
                             label = "Explore by State", 
                             choices = IPEDS_data_2$`State abbreviation`,
                             multiple = FALSE), 
                
                           plotOutput("stateenrollment"), 
                
                           plotOutput("statesat25th"), 
                
                           plotOutput("statesat75th"), 
               
                           plotOutput("statetuition"), 
                
                           selectInput(
                             inputId = "exploreregion", 
                             label = "Explore by State", 
                             choices = IPEDS_data_2$`Geographic region`,
                             multiple = FALSE), 
                
                           plotOutput("regionenrollment"), 
                            
                           plotOutput("regionsat25th"), 
                            
                           plotOutput("regionsat75th"), 
                            
                           plotOutput("regiontuition"), 
                    )
      
      
                  tabPanel("Compare Colleges", 
                         
                              selectizeInput('compareinput', 'Select Schools', IPEDS_data$Name, multiple=TRUE),
                           
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
