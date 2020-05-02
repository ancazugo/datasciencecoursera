rankHospital <- function(state, outcome, num = 'best') {
    ans <- NA
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
        finalTable <- subset(dataset, dataset['State'] == toupper(state))
        #Order by outcome and name, and remove rows with NAs
        finalTable <- finalTable[order(finalTable[column], finalTable['Hospital.Name']), ]
        finalTable <- finalTable[!is.na(finalTable[column]), ]
        #Number of rows in the final dataset
        row_n <-nrow(finalTable)
        #Fill a new column with their ranking
        finalTable$Rank <- 1:row_n
        
        #Check if num is in the finalDataset
        if(as.numeric(num) %in% 1:row_n) {
          ans <- finalTable[as.numeric(num), 1]  
        }
        #Check if num is best
        else if(num == 'best') {
            ans <- finalTable[1, 1]
        }
        #Check if num is worst
        else if(num == 'worst') {
            ans <- finalTable[row_n, 1]
        }
    }
    #Return answer
    return(ans)
}
