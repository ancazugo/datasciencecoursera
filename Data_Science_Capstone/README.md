Swiftkey Shiny App - Get Data
================
Andres Camilo Zuñiga Gonzalez
25/8/2020

This is the explanation of how to get the data from the English
documents for the Coursera Data Science Capstone on Word Prediction with
SwiftKey Data

1.  Load necessary packages

<!-- end list -->

``` r
library(tidytext) #text handling
library(parallel) #parallel processing
```

2.  Create the strings for reading the files and load the stop\_words
    dataset from the `tidytext` package

<!-- end list -->

``` r
files <- c('en_US/en_US.blogs.txt', 'en_US/en_US.news.txt', 'en_US/en_US.twitter.txt')
types <- c('blogs', 'news', 'twitter')
data("stop_words")
stop_words_c <- stop_words$word
```

3.  Since datasets are huge, I will process them in parallel using a
    modified `apply()` function from the `parallel` package

<!-- end list -->

  - Load each package and variable in the clusters with `clusterEvalQ()`
    and `clusterExport()`, respectively
  - Sample 10% of the text lines randomly.
  - Unnest tokens in n-grams and count each occurrence.
  - Separate n-grams in n columns (e.g., 2-gram in two columns).
  - Stop clusters.
  - Rename the list.

<!-- end list -->

``` r
ncores <- 3
cl <- makePSOCKcluster(ncores)
clusterEvalQ(cl, library(readr))
clusterEvalQ(cl, library(dplyr))
clusterEvalQ(cl, library(tidyr))
clusterEvalQ(cl, library(tidytext))
clusterExport(cl, "files")
clusterExport(cl, "types")
start <- Sys.time()
word_grams <- parLapply(cl, seq(files[1:3]), function(i) {
  set.seed(123456)
  pct <- 0.1
  file <- read_lines(files[i], skip_empty_rows = T)

  text <- tibble(text = file) %>%
    sample_n(., pct * nrow(.))

  bigram_count <- text %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
    count(bigram, sort = TRUE) %>%
    separate(bigram, c("word1", "word2"), sep = " ")
  
  trigram_count <- text %>%
    unnest_tokens(trigram, text, token = "ngrams", n = 3) %>%
    count(trigram, sort = TRUE) %>%
    separate(trigram, c("word1", "word2", "word3"), sep = " ")
  
  return(list(bigram_count = bigram_count, trigram_count = trigram_count))
})

end <- Sys.time()
time <- end - start
stopCluster(cl)

names(word_grams) <- types
```

4.  Save the word column from the stop words dataset as an R object
5.  Save the the list of datasets as an R object

<!-- end list -->

``` r
saveRDS(stop_words_c, file = 'SwiftkeyShinyApp/data/stop_words.rds')
saveRDS(object = word_grams, file = 'SwiftkeyShinyApp/data/word_grams.rds')
```

6.  Visit the Shiny App
    [here](https://ancazugo.shinyapps.io/SwiftkeyShinyApp/).
7.  See the pitch slides [here](https://rpubs.com/ancazugo/swiftkeyapp).
