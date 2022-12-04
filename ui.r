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
    
    mainPanel(
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Search by Your Stats",
                     numericInput(

                         inputId = "statsinput",
                         label = "Enter SAT",
                          value = "0",
                          min = "0",
                          max = "1600",
                          step = 10),
                     
                     actionButton("submit","Submit Score", icon("submit"), width = NULL),
                    
                     tableOutput("schoolTable")
                    ),
                          
                           

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
                           selectizeInput(
                             inputId = "exploreschool", 
                             label = "Explore by School", 
                             choices = as.list(IPEDS_data_2$Name), 
                             multiple = FALSE),
                           
                           DT::dataTableOutput("searchtable"), 
                
                           leafletOutput("map"),
                
                           selectInput(
                             inputId = "explorestate",
                             label = "Explore by State", 
                             choices = IPEDS_data$`State abbreviation`,
                             multiple = FALSE), 
                
                           plotOutput("stateenrollment"), 
                
                           plotOutput("statesat25th"), 
                
                           plotOutput("statesat75th"), 
               
                           plotOutput("statetuition"), 
                
                           selectInput(
                             inputId = "exploreregion", 
                             label = "Explore by State", 
                             choices = IPEDS_data$`Geographic region`,
                             multiple = FALSE), 
                
                           plotOutput("regionenrollment"), 
                            
                           plotOutput("regionsat25th"), 
                            
                           plotOutput("regionsat75th"), 
                            
                           plotOutput("regiontuition"), 
                    ),
      
      
                  tabPanel("Compare Colleges", 
                           selectizeInput('compareinput1', 'School 1', IPEDS_data_2$Name, multiple=FALSE), 
                
                           selectizeInput('compareinput2', 'School 2', IPEDS_data_2$Name, multiple=FALSE),
                      
                           selectizeInput('compareinput3', 'School 3', IPEDS_data_2$Name, multiple=FALSE),
                         
                           selectizeInput('compareinput4', 'School 4', IPEDS_data_2$Name, multiple=FALSE),
                          
                           selectizeInput('compareinput5', 'School 5', IPEDS_data_2$Name, multiple=FALSE),
                           
                           actionButton("goButton", "Compare"),

                           
                           plotOutput('selectInput')
                           
                           )
      ))))


                           
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

   
                          
<<<<<<< HEAD
                           column(width = 4,
                                  plotOutput("plot", height = 300,
                                      click = clickOpts(id = "plot_click"),
                                      hover = hoverOpts(id = "plot_hover", delayType = "throttle"),
                                      brush = brushOpts(id = "plot_brush")
                                  ),
                                  h4("Clicked points"),
                                  tableOutput("plot_clickedpoints")
                                  ),
                           column(width = 4,
                                  verbatimTextOutput("plot_clickinfo"),
                                  )
                     
                  )))))

=======
                         
    
>>>>>>> b43659f8d7999564ffdc4c6cc1905d054a64d9f4
