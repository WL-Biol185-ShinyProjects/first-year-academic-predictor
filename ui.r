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
                         plotOutput(
                           "statesat25th",
                           brush = "statesat25thbrush"
                         ), 
                         tableOutput("exploredata1")
                  ), 
                  column(6,
                         plotOutput(
                           "regionsat25th", 
                           brush = "regionsat25thbrush"
                         ), 
                         tableOutput("exploredata2")
                  )
                ), 
                
                fluidRow(
                  column(6, 
                         plotOutput(
                           "statesat75th", 
                           brush = "statesat75thbrush"
                         ), 
                         tableOutput("exploredata3")
                  ), 
                  column(6,
                         plotOutput(
                           "regionsat75th", 
                           brush = "regionsat75thbrush" 
                         ), 
                         tableOutput("exploredata4")
                  )
                ),
                
                fluidRow(
                  column(6, 
                         plotOutput(
                           "statetuition", 
                           brush = "statetuitionbrush"
                         ), 
                         tableOutput("exploredata5")
                  ), 
                  column(6,
                         plotOutput(
                           "regiontuition",
                           brush = "regiontuitionbrush"
                         ), 
                         tableOutput("exploredata6")
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

                           fluidRow(
                             plotOutput("schoolcompare")
                           )
                                   
       
                  )
                  )
      )
    )


