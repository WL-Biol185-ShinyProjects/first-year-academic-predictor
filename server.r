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
    output$plot <- renderPlot({
      input$goButton
      plot(compareinput1:compareinput5, ), res = 96)
    }
}
)
