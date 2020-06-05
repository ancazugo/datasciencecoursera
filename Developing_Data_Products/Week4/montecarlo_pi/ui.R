library(shiny)

# Define UI for application that draws a plot
shinyUI(fluidPage(

    # Application title
    titlePanel("Estimation of π via Montecarlo"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1('Montecarlo π parameters'),
            numericInput('radius', 'Circle Radius', min = 1, max = 100, step = 0.1, value = 1),
            numericInput('points', 'Number of Random Points', min = 0, max = 10^7, step = 1, 10),
            numericInput('seed', 'Set Seed for Random Points',
                         min = -10^7, max = 10^7, step = 1, value = 123456),
            #('seedy', 'Set Numeric Seed for Y Coordinates', min = 1, max = 10^7, step = 1, 654321),
            checkboxInput('circle', 'Draw Circle', value = T),
            checkboxInput('square', 'Draw Square', value = T),
            uiOutput('see')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            # textOutput('text'),
            plotOutput("piPlot", width = '70%', height = "auto")
        )
    )
))
