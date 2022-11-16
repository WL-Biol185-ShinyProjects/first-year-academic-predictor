library(shiny)
library(leaflet)

function(input, output, session) {
  
#Tabs 
  #Stats 
  
 output$schoolTable <- renderTable(IPEDS_data_2$`Total SAT 75th Percentile`)
    
   
    
  #School 
    output$schooloutput <-  DT::renderDataTable({
      search_by_df
    }, options = list(pageLength = 1))
 
     #Compare
<<<<<<< HEAD
    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)

  
      
}
=======
    output$plot <- renderPlot({
      input$goButton
      plot(compareinput1:compareinput5, ), res = 96)
    }
}
)
>>>>>>> 438d3e489aad2bbee5c8422ac7bc839164455cf4
