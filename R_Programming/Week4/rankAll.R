rankAll <- function(outcome, num = "best") {
    ans <- data.frame()
    #Load the data, select the important columns and convert them to numeric where appropriate
    dataset <- read.csv("R_Programming/Week4/outcome-of-care-measures.csv", colClasses = "character")
    dataset <- subset(dataset, select = c(2, 7, 11, 17, 23))
    dataset[, 3] <- as.numeric(dataset[, 3])
    dataset[, 4] <- as.numeric(dataset[, 4])
    dataset[, 5] <- as.numeric(dataset[, 5])
    #A switch scenario for the outcomes
    condition <- switch(outcome, 'heart attack' = 'Heart.Attack',
                        'heart failure' = 'Heart.Failure',
                        'pneumonia' = 'Pneumonia')
    #A character of the long name in the outcome columns
    col_long <- 'Hospital.30.Day.Death..Mortality..Rates.from.'
    #Test if outcome is invalid
    if(is.null(condition)) {
        stop('Invalid outcome')
    } else {
        #Concatenate long column name and the result of switch
        column <- paste(col_long, condition, sep = '')
        #Order by state, outcome and name
        dataset <- dataset[order(dataset['State'], dataset[column], dataset['Hospital.Name']), ]
        #Remove rows with NA in the desired outcome
        dataset_noNA <- dataset[!is.na(dataset[column]), ]
        
        byState <- split(dataset_noNA, dataset_noNA$State)
        
        for(state in byState) {
            row_n <- nrow(state)
            state$Rank <- 1:row_n
            #Check if num is in the finalDataset
            if(num %in% 1:row_n) {
                ans <- rbind(ans, state[num, c(1, 2, 6)])
            }
            #Check if num is best
            else if(num == 'best') {
                ans <- rbind(ans, state[1, c(1, 2, 6)])
            }
            #Check if num is worst
            else if(num == 'worst') {
                ans <- rbind(ans, state[row_n, c(1, 2, 6)])
            } else {
                state <- rbind(state, c(NA, state[1, 2], row_n))
                ans <- rbind(ans, state[row_n+1, c(1, 2, 6)])
            }
        }
    }
    return(ans)
}
