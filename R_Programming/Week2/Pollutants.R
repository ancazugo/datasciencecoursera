folder <- 'R_Programming/Week2/specdata/'

pollutantmean <- function(directory, pollutant, id = 1:332) {
    fullTable <- data.frame()
    for(n in id) {
        fileName <- paste(directory, formatC(n, width = 3, flag = '0'), '.csv', sep = '')
        dataset <- read.delim(fileName, sep = ',')
        fullTable <- rbind(fullTable, dataset)
    }
    mean(fullTable[[pollutant]], na.rm = T)
}

complete <- function(directory, id = 1:332) {
    table <- data.frame()
    files <- list.files(path = directory, pattern = '*.csv')
    for(n in id) {
        fileName <- paste(directory, files[n], sep = '')
        dataset <- read.delim(fileName, sep = ',')
        dataset <- dataset[complete.cases(dataset),]
        row <- c(n, nrow(dataset))
        table <- rbind(table, row)
    }
    colnames(table) <- c('id', 'nobs')
    return(table)
}

corr <- function(directory, threshold = 0) {
    ans <- c()
    files <- list.files(path = directory, pattern = '*.csv')
    for(file in files) {
        fileName <- paste(directory, file, sep = '')
        dataset <- read.delim(fileName, sep = ',')
        dataset <- dataset[complete.cases(dataset),]
        if(threshold <= nrow(dataset)){
           ans <- append(ans, cor(dataset$nitrate, dataset$sulfate))
        }
        else {
            next
        }
    }
    return(ans)
}
