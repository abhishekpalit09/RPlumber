setwd("C:/Users/palitabhishek/Documents/Analysis/Deploy/PlumberBody1")

library(plumber)
# 'plumber.R' is the location of the file shown above
pr("plumber.R") %>%
  pr_run(port=8000)