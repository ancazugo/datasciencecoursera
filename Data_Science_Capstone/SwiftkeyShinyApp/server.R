library(shiny)
library(dplyr)
library(tidyr)
library(wordcloud2)

# Define server logic required to draw wordcloud
shinyServer(function(input, output, session) {
    
    url <- a("Slides", href="https://rpubs.com/ancazugo/swiftkeyapp")
    output$see <- renderUI({tagList("Visit these ", url, 'for more information')})
    output$wordcloud <- renderWordcloud2({
        
        data <- readRDS('data/word_grams.rds')
        user_words <- input$text
        database <- tolower(input$databases)
        len_words <- length(strsplit(user_words, ' ')[[1]])
        ngrams <- ifelse(len_words <= 1, 'bigram_count', 'trigram_count')
        user_tibble <- tibble(data[[database]][[ngrams]])
        
        
        searchNgrams <- function(dataframe, words) {
            
            df <- dataframe
            words <- tolower(strsplit(words, ' ')[[1]])
            n <- length(words)

            if(n == 0) {
                df <- data.frame(word1 = c('TYPE', 'SOME', 'WORDS'), n = 1)
            }
            else if(n >= 3) {
                df <- data.frame(word1 = words, n = seq(500, 100, length.out = length(words)))
            }
            else if(n == 1) {
                df <- df %>%
                    filter(word1 == words[1]) %>%
                    unite(bigram, word1, word2, sep = " ")
            } 
            else if(n == 2) {
                df <- df %>%
                    filter(word1 == words[1]) %>%
                    filter(word2 == words[2]) %>%
                    unite(trigram, word1, word2, word3, sep = " ")
            }
            
            return(df)
        }
        
        filterStopWords <- function(dataframe) {
            df <- dataframe
            stop_words <- readRDS('data/stop_words.rds')
            
            if(colnames(df)[1] == 'bigram') {
                df <- df %>%
                    separate(bigram, c("word1", "word2"), sep = " ") %>%
                    filter(!word2 %in% stop_words) %>%
                    unite(bigram, word1, word2, sep = " ")
            }
            
            else if(colnames(df)[1] == 'trigram') {
                df <- df %>%
                    separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
                    filter(!word3 %in% stop_words) %>%
                    unite(trigram, word1, word2, word3, sep = " ")
            }
            
            return(df)
        }
        
        # filterStopWords(searchNgrams(data$blogs$trigram_count, 'play to'))
        
        final_df <- searchNgrams(user_tibble, user_words)
        
        if(input$stopwords) {
            final_df <- filterStopWords(final_df)
        }
        
        if(nrow(final_df) == 0) {
            final_df <- data.frame(word1 = c('WORDS', 'NOT', 'FOUND'), n = 1)
        }
        
        shape <- sample(c('circle', 'cardioid', 'diamond', 'triangle-forward', 'triangle', 'pentagon', 'star'), 1)
        
        color <- switch(database, 'blogs' = rgb(red = 244, green = 77, blue = 8, maxColorValue = 255),
                        'news' = rgb(red = 198, green = 0, blue = 0, maxColorValue = 255),
                        'twitter' = rgb(red = 0, green = 167, blue = 231, maxColorValue = 255))
        
        wordcloud2(final_df, shape = shape, backgroundColor = color)
        
    })
    
})

