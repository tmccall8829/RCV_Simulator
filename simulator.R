# Alternative vote/instant run-off/ranked choice voting simulator
# by Thomas McCall

# clear things first, just in case
rm(list=ls())

# start with a voting population of size n, and c candidates
c <- c("a", "b", "c", "d", "e")
n <- 1000

vote_data <- data.frame(matrix(NA, nrow=n, ncol=length(c)))
colnames(vote_data) <- c("Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5")

# for each person in n, randomly generate a preference list for all candidates
#set.seed(60657)
for (i in 1:n) {
  vote_data[i,] <- sample(c, length(c))
}

# sum up the total votes for each candidate
first_choice_totals <- table(vote_data$`Choice 1`)
second_choice_totals <- table(vote_data$`Choice 2`)
third_choice_totals <- table(vote_data$`Choice 3`)
fourth_choice_totals <- table(vote_data$`Choice 4`)
fifth_choice_totals <- table(vote_data$`Choice 5`)

# start calculating the totals for each round
# note: there will be len(c) - 1 rounds
smallest <- n+1 # this is an impossible value for anyone to obtain
for (i in 1:length(first_choice_totals)) {
  if (first_choice_totals[[i]] < smallest) {
    smallest <- first_choice_totals[[i]]
  }
}
glue::glue("Smallest voteshare in first round: {first_choice_totals[first_choice_totals == smallest]}.")




# create a table with the results of each round and the final winner
  
