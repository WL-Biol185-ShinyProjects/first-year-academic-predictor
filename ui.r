library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)


ui <- fluidPage(
  
  # App title ----
  titlePanel("College Search: SAT Score"),
    
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
                 
                 fluidRow(
                   h4("Explore by School")
                 ),
                
                 #selectizeInput("searchschool", 
                  #"Explore by School", 
                  #choices = as.list(IPEDS_data_2$Name), 
                  #multiple = FALSE),
                             
                DT::dataTableOutput("searchtable"), 
                
                fluidRow(
                  leafletOutput("map")
                ),
                
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
         
         fluidRow(
           column(6, 
                  selectInput(
                    inputId = "compareaid",
                    label = "Select to Compare Aid", 
                    choices = IPEDS_data_2$Name,
                    multiple = TRUE),
         
         fluidRow(
            column(6, 
                  plotOutput("distPlot")
                    ) 
         
)
)
                            
      )
    )
))
)



