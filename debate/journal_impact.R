# journal_impact.R
# rough stats on journal impact factors for debate
# Sep 2024
library(janitor)
library(stringr)
library(dplyr)

# data from https://www.scimagojr.com/journalrank.php?area=2700&type=j
raw = read.table('debate/scimagojr 2023  Subject Area - Medicine.csv', sep=';', header=TRUE, fill=TRUE) %>%
  clean_names() %>%
  select(title, sjr, total_docs_3years, total_cites_3years, citable_docs_3years) %>%
  mutate(sjr = as.numeric(str_remove(sjr,','))) %>%
  arrange(desc(sjr)) # high to low

# total sites for all qual journals
total_qual = filter(raw, str_detect(tolower(title), pattern='qualitative')) %>%
  summarise(sum = sum(total_cites_3years))

# how many citations for one journal
raw$total_cites_3years[1] / total_qual$sum
