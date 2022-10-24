library(shiny)
library(leaflet)

function(input, output, session) {
  
#Tabs 
  #Stats 
  #School 
    output$schooloutput <- renderPrint(input$schoolinput)
  #Compare
    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)
  
}