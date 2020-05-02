best <- function(state, outcome) {
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
    } 
    #Test if state is invalid
    else if(!(toupper(state) %in% unique(dataset$State))) {
        stop('Invalid State')
    } else {
        #Concatenate long column name and the result of switch
        column <- paste(col_long, condition, sep = '')
        #Filter by state
        ans <- subset(dataset, dataset['State'] == toupper(state))
        #Order by outcome and name
        ans <- ans[order(ans[column], ans['Hospital.Name']), ]
    }
    #Return answer
    return(ans[1, 1])
}
