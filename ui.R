#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

data("mtcars")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("US Vehicle MPG Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(h4("Choose Vehicle Factors"),
       selectInput("cyl","Cylinder", (sort(unique(mtcars$cyl)))),
       selectInput("gear","Gear",(sort(unique(mtcars$gear)))),
       selectInput("am","Transmission (0-MT,1-AT)",(sort(unique(mtcars$am)))),
       sliderInput("lm","hp",min = min(mtcars$hp), max = max(mtcars$hp),
                   value = max(mtcars$hp)/2,step=1),
       h4("Predicted MPG"), verbatimTextOutput("predict"),width = 4
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       "Vehicle MPG",plotOutput("distPlot")
    )
  )
))
