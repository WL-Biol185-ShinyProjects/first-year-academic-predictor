library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)

function(input, output, session) {
  
#Tabs 
  #Stats 
      output$schooltable <- DT::renderDataTable(filter(IPEDS_data_2, `Total SAT 25th Percentile` + 50 <= input$statsInput, `Total SAT 75th Percentile` - 50 >= input$statsInput),
                                                options= list(scrollX= TRUE),
                                                rownames= FALSE)
      

  
  #School 
    output$schooloutput <-  renderTable({
      search_by_df %>% 
        filter(input$schoolinput) 
    })

    output$search_by_map <- renderLeaflet({
      IPEDS_data_2 %>%
        filter(input$schoolinput) %>% 
        leaflet() %>% 
        setView(lng == IPEDS_data_2$`Longitude location of institution`, 
                lat == IPEDS_data_2$`Latitude location of institution`, 
                zoom = 12) %>% 
        addTiles()
    })
    


  output$Target_Schools <- renderTable(IPEDS_data_2 %>%
                                        filter(input$statsinput >= `Total SAT 25th Percentile`)
)
  
 output$schoolTable <- renderTable(IPEDS_data_2$`Total SAT 75th Percentile`)
    
   
  
 
 
 
 
 
 
 

 
 

     #Compare

    output$comparecolleges <- renderPlot({
      ggplot2::aes(IPEDS_data$Name,
                   IPEDS_data$`Tuition and fees, 2013-14`, 
                   color = IPEDS_data$`Control of institution`)
  
    output$click_info <- renderPrint({
      nearPoints(IPEDS_data_2, input$plot_clickedpoints, addDist = TRUE)
})
})
}





