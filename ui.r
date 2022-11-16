library(shiny)

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
                         inputId = "statsinput",
                         label = "Enter SAT",
                          value = "0",
                          min = "0",
                          max = "1600",
                          step = 10),
                     
                     actionButton("submit","Submit Score", icon("submit"), width = NULL),
                     
                     DT:: dataTableOutput("schooloutput")
                       
                     ),
                          
                           
                  
                  tabPanel("Search by Colleges", 
                           selectizeInput('schoolinput', 'Search by School', IPEDS_data$Name, multiple=TRUE),
                           verbatimTextOutput('schooloutput')
                           ),
                  
                  tabPanel("Compare Colleges", 
                           selectInput('compareinput1', 'School 1', IPEDS_data_2$Name, multiple=FALSE, selectize=TRUE), 
                
                           selectInput('compareinput2', 'School 2', IPEDS_data_2$Name, multiple=FALSE, selectize=TRUE),
                      
                           selectInput('compareinput3', 'School 3', IPEDS_data_2$Name, multiple=FALSE, selectize=TRUE),
                         
                           selectInput('compareinput4', 'School 4', IPEDS_data_2$Name, multiple=FALSE, selectize=TRUE),
                          
                           selectInput('compareinput5', 'School 5', IPEDS_data_2$Name, multiple=FALSE, selectize=TRUE),
                           
                           actionButton("goButton", "Compare"),
   
                           plotOutput("plot_output", width = "400px"),
                           
                           
             )
         )
      )
   ))
