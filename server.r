library(shiny)
library(leaflet)

function(input, output, session) {
  
#Tabs 
  #Stats 
  output$schooloutput <- DT::renderDataTable(IPEDS_data_2)
  
   
    
  #School 
    output$schooloutput <-  DT::renderDataTable({
      search_by_df
    }, options = list(pageLength = 1))
 
     #Compare
       observe({
         updateSelectInput(session, "header_input", label = "Area of Interest", choices = colnames(IPEDS_data_2))
         })
       
    output$plot <- renderPlot({
      input$goButton
      hist(IPEDS_data_2, input$header_input, xlab = input$header_input, main=input$data_input, res = 96)
    
    })
}
    
    
