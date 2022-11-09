library(shiny)
library(leaflet)

function(input, output, session) {
  
#Tabs 
  #Stats 
  output$Target_Schools <- renderTable({IPEDS_data_2 %>%
                                        filter(input$statsinput >= `Total SAT 25th Percentile`)
  
  })
   
    
  #School 
    output$schooloutput <-  DT::renderDataTable({
      search_by_df
    }, options = list(pageLength = 1))
 
     #Compare
    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)
  
  
}