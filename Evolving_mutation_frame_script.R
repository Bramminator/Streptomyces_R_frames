#Cost and population plots for the run in which mutants cannot sporulate.
.libPaths('~/R/x86_64-pc-linux-gnu-library/3.6')
library(tidyverse)
library(ggplot2)
# Read in the data
# I am a plasmatelevision
all_runs <- list.dirs("/hosts/linuxhome/mutant26/tmp/bramve/", full.names = TRUE, recursive = FALSE)
# Select runs of interest
runs <- grep('evolving_mutation_mutants_seeded_fifthmutants_produce', all_runs, value = TRUE)
# runs <- runs[-1]
# Empty frame and list before next run

# define empty list

pop_list <- list()
# Read in population data

for(i in runs){
  temppop <- read.table(paste0(i, "/popsize2.txt"), header = TRUE, sep = '\t', row.names = NULL)
  temppop <- gather(temppop, "type", "count", -"Time")
  initial_cost <- 0.1
  temppop$initial_cost <- rep(initial_cost, times = nrow(temppop))
  initial_production <- 0.3
  temppop$initial_production <- rep(initial_production, times = nrow(temppop))
  number_sensitives <- 1000
  temppop$number_sensitives <- rep(number_sensitives, times = nrow(temppop))
  nastiness <- 2
  temppop$nastiness <- rep(nastiness, times = nrow(temppop))
  seed <- as.numeric(gsub('^.*r', '', i))
  temppop$seed <- rep(seed, times = nrow(temppop))
  pop_list[[i]] <- temppop
}
# Create frame from list
Population_frame <- do.call(rbind, pop_list)
Population_frame$Time <- as.numeric(as.character(Population_frame$Time))
row.names(Population_frame) <- NULL
saveRDS(Population_frame, '~/R/evolving_museeded_mutation_fifth_reproduce_popframe.rds')


# Empty cost frame and list

# Define empty list
costs_list <- list()

# Read in Cost data
for(i in runs){
  tempcosts <- read.csv(paste0(i, '/costs_concentration_production.txt'), header = TRUE, sep = '\t', row.names = NULL)
  colnames(tempcosts) <- c("Time", "Cost", "Concentration","Production", "Mutation", "X", "Y")
  tempcosts$Time <- as.numeric(tempcosts$Time)
  initial_cost <- 0.1
  tempcosts$initial_cost <- rep(initial_cost, times = nrow(tempcosts))
  initial_production <- 0.3
  tempcosts$initial_production <- rep(initial_production, times = nrow(tempcosts))
  number_sensitives <- 1000
  tempcosts$number_sensitives <- rep(number_sensitives, times = nrow(tempcosts))
  nastiness <- 2
  tempcosts$nastiness <- rep(nastiness, times = nrow(tempcosts))
  seed <- as.numeric(gsub('^.*r', '', i))
  tempcosts$seed <- rep(seed, times = nrow(tempcosts))
  costs_list[[i]] <- tempcosts
}

# Make frame from list
costs_frame <- do.call(rbind, costs_list)
costs_frame$Time <- as.numeric(as.character(costs_frame$Time))
print(class(costs_frame$seed))
saveRDS(costs_frame, '~/R/evolving_museeded_mutation_fifth_reproduce_costframe.rds')



print("done")

