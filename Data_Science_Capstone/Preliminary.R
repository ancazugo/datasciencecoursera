#Change working directory
setwd('./Data_Science_Capstone/')

#Read the us files partially
twitterEN <- file('en_US/en_US.twitter.txt')
grep('biostats', readLines(twitterEN))
readLines(twitterEN)[556872]

grep('A computer once beat me at chess, but it was no match for me at kickboxing', readLines(twitterEN))

love <- length(grep('love', readLines(twitterEN)))
hate <- length(grep('hate', readLines(twitterEN)))
love/hate
close(twitterEN)
