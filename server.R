#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(curl)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  data("mtcars")
  
  output$distPlot <- renderPlot({
    
  mtcars1 <- subset(mtcars,cyl == input$cyl & gear == input$gear & am == input$am)
    
  MPGplot <- ggplot(data = mtcars1, aes(x = hp, y = mpg)) + geom_point()
  MPGplot <- MPGplot + geom_smooth(method = "lm") + xlab("Horse Power") + ylab("Miles per Gallon")
  MPGplot
    
  })
  
  output$predict <- renderPrint({
    mtcars1 <- subset(mtcars,cyl == input$cyl & gear == input$gear & am == input$am)
    fit <- lm(mpg~hp, data = mtcars1)
    unname(predict(fit,data.frame(hp = input$lm)))
  })
  
  observeEvent(input$predict,{
    distPlot <<- NULL
    output$distPlot <- renderPlot({
      ggplot(data = mtcars1, aes(x = hp, y - mpg)) + geom_point() +
        geom_smooth(method = "lm") + xlab("Horse Power") + ylab("Miles per Gallon")
    })
  })
  
})
