library(shiny)
library(leaflet)
library(tidyverse)

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
 data <- reactive({
         updateSelectizeInput(session, "header_input", label = "Area of Interest", choices = colnames(IPEDS_data_2), server = TRUE)
       
       

    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)


  data <- reactive({
    input$newplot
    IPEDS_data_2 + rnorm(nrow(IPEDS_data_2))


    output$plot <- renderPlot({
      input$goButton
      hist(IPEDS_data_2, input$header_input, xlab = input$header_input, main=input$data_input, res = 96)
    
    })


    
    




  output$plot <- renderPlot({
    plot(IPEDS_data$`Tuition and fees, 2013-14`, IPEDS_data$`Percent of freshmen receiving any financial aid`, color = 'Name')
  })
  
  output$plot_clickinfo <- renderPrint({
    cat("Click:\n")
    str(input$plot_click)
  })
  
  output$plot_hoverinfo <- renderPrint({
    cat("Hover (throttled):\n")
    str(input$plot_hover)
  })
  
  output$plot_brushinfo <- renderPrint({
    cat("Brush (debounced):\n")
    str(input$plot_brush)
  })
  
  output$plot_clickedpoints <- renderTable({
    IPEDS_data_2 <- nearPoints(data, input$plot_click, "Name", "Tuition and fees, 2013-14")
    if (nrow(IPEDS_data_2) == 0)
      return()
    res
  })
      hist(IPEDS_data_2, input$header_input, xlab = input$header_input, main=input$data_input, res = 96)
 })
}
    

