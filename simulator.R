# Alternative vote/instant run-off/ranked choice voting simulator
# by Thomas McCall

# how does the algo even work?
# 1) everybody votes (in this case, for a fixed number of 5 candidates)
# ----> number of rounds of calculating = number of candidates - 1
# 2) for each round, find the person who got the lowest number of votes
#    eliminate that candidate, and for all the people who voted for that 
#    candidate, redistribute their 2nd choice votes to each candidate
# 3) repeat that process until you end up with 2 candidates, and then decide who
#    wins using simple majority!
# 4) profit

# clear things first, just in case
rm(list=ls())

# start with a voting population of size n, and c candidates
candidates <- c("a", "b", "c", "d", "e")
n <- 1000

vote.data <- data.frame(matrix(NA, nrow=n, ncol=length(candidates)))
colnames(vote.data) <- c("Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5")

# for each person in n, randomly generate a preference list for all candidates
# set.seed(60657) # don't set a seed so its random each time
# each row in the table represents the ranked choices for a single voter
for (i in 1:n) {
  vote.data[i,] <- sample(candidates, length(candidates))
}

# sum up the total votes for each candidate
# first_choice_totals <- table(vote_data$`Choice 1`) # too easy!!
# I don't wrap ifelse() in sum(), even though I could, because I want to hang
# onto these vectors for the redistribution process
a.round.1 <- ifelse(vote.data$`Choice 1` == "a", 1, 0)
b.round.1 <- ifelse(vote.data$`Choice 1` == "b", 1, 0)
c.round.1 <- ifelse(vote.data$`Choice 1` == "c", 1, 0)
d.round.1 <- ifelse(vote.data$`Choice 1` == "d", 1, 0)
e.round.1 <- ifelse(vote.data$`Choice 1` == "e", 1, 0)
round.1.totals <- c(sum(a.round.1), sum(b.round.1), sum(c.round.1), sum(d.round.1), sum(e.round.1))

# start calculating the totals for each round
# note: there will be len(candidates) - 1 rounds
round.1.loser <- candidates[which(round.1.totals == min(round.1.totals))]

glue::glue("Smallest voteshare in first round: candidate {round.1.loser}.")

# now, go through vote.data and find the people who put the round 1 loser first
# redistribute their 2nd choice votes and re-tally
candidates <- candidates[candidates != round.1.loser]
for (cand in 1:length(candidates)) { 
  round.2[cand] <- sum(ifelse(vote.data$`Choice 2` == candidates[cand], 1, 0))
}
