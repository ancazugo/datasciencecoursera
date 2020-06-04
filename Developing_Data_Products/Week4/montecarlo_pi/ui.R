#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("International Football Head to Head"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1('Montecarlo Pi parameters'),
            h2('Pick a radius value'),
            numericInput('radius', 'radius', min = 1, max = 100, step = 1),
            h2('Pick a number of random points'),
            numericInput('points', 'points', min = 0, max = 10^6, step = 1),
            checkboxInput('show_circle', inputId = 'show_circle', value = T)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h1('Montecarlo Estimation of Pi'),
            plotOutput("piPlot"),
            p('The estimated value of pi with x random points is')
        )
    )
))
