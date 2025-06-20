# nhanes.R
# looking at NHANES papers from PLOS ONE paper
# https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.3003152
# June 2025
setwd('fraud')
library(dplyr)
library(readxl)
library(stringr)
library(janitor)

# get data and scan for keywords
nhanes = read_excel(path = 'data/pbio.3003152.s001.xlsx', sheet='Table A', skip=2) %>% 
  clean_names()
# find commonly used combinations
common = group_by(nhanes, predictor_variable, health_condition) %>%
  tally() %>%
  ungroup() %>%
  arrange(desc(n)) %>%
  head() 
common
top_three = slice(common, 1:3)

to_show = left_join(common, nhanes, by=c('predictor_variable', 'health_condition')) %>%
  pull(title)
