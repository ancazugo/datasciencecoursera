library(shiny)
library(wordcloud2)

# Define UI for application that draws a plot
shinyUI(fluidPage(
    
    # Application title
    titlePanel("SwiftKey Word Prediction"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h1('N-gram Word Prediction'),
            textInput(inputId = 'text', label = 'Type up to two (2) words'),
            selectInput(inputId = 'databases', label = 'Choose the text type you want to search',
                        choices = c('Blogs', 'News', 'Twitter')),
            # selectInput(inputId = 'ngrams', label = 'Choose the n-grams',
            #             choices = c('2-gram', '3-gram')),
            checkboxInput('stopwords', 'Remove Stop Words (e.g., the, of, in) as prediction', value = F),
            hr(),
            uiOutput('see')
        ),
        
        # Show a wordcloud
        mainPanel(
            wordcloud2Output(outputId = 'wordcloud', width = '90%', height = '700px')
        )
    )
))
