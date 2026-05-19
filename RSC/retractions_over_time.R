# retractions_over_time.R
# May 2026
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)
library(rentrez) # for Pubmed

# get the latest retraction data from crossref
my.email = 'a.barnett@qut.edu.au'
url = paste(
  "https://api.labs.crossref.org/data/retractionwatch?mailto=",
  my.email,
  sep = ''
)
destfile = file.path(tempdir(), 'retractions.csv') # put in temporary folder
download.file(url, destfile = destfile, method = 'curl')
# now read into a csv
retractions = read.csv(destfile) %>%
  filter(
    RetractionNature == 'Retraction', # only retractions
    OriginalPaperPubMedID != 0
  ) %>% # must have a pubmed ID
  select(
    OriginalPaperDOI,
    OriginalPaperPubMedID,
    Journal,
    OriginalPaperDate,
    RetractionDate
  ) %>%
  rename('doi' = 'OriginalPaperDOI') %>%
  separate(RetractionDate, into = c('ret_date', NA), sep = ' ') %>%
  separate(OriginalPaperDate, into = c('date', NA), sep = ' ') %>%
  mutate(
    doi = str_squish(doi),
    doi = tolower(doi),
    date = as.Date(date, '%m/%d/%Y'),
    year = as.numeric(format(date, '%Y')),
    ret_date = as.Date(ret_date, '%m/%d/%Y')
  ) %>%
  unique() %>%
  filter(year >= 2005)
# delete file to tidy up
unlink('retractions.csv')

## denominator from PubMed
## Part 1: get BMJ papers from pubmed ##
years = 2005:2026
all_search = NULL
for (y in years) {
  query = paste0(y, '[pdat]') #
  psearch = entrez_search(db = 'pubmed', term = query, retmax = 10)
  f = data.frame(year = y, denominator = psearch$count)
  all_search = bind_rows(all_search, f) # concatenate search counts
}

## counts of retractions by year
counts = group_by(retractions, year) %>%
  tally() %>%
  ungroup() %>%
  left_join(all_search, by = 'year') %>%
  mutate(rate = 100 * n / denominator) # percent

# plot
colour = 'darkred'
nplot = ggplot(data = counts, aes(x = year, y = rate)) +
  geom_point(col = colour, size = 3) +
  geom_line(col = colour) +
  theme_bw() +
  theme(panel.grid.minor = element_blank()) +
  xlab('Publication year') +
  ylab('Percent of retractions')
nplot
ggsave(
  filename = 'figures/retractions.jpg',
  plot = nplot,
  width = 5,
  height = 4.5,
  units = 'in',
  dpi = 500
)

# check 2022
filter(retractions, year == 2022) %>%
  group_by(Journal) %>%
  tally() %>%
  arrange(desc(n)) %>%
  slice(1:5)
