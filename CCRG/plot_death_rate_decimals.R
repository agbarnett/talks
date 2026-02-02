# plot_death_rate_decimals.R
# plot the death rate to show silly decimal places
# January 2026
library(ggplot2)
library(dplyr)

# simple data frame
death_rate = 238.78 
rates1 = data.frame(x = 1, rate = c(death_rate, 10000-death_rate), group = c(2,1))
death_rate = 238
rates2 = data.frame(x = 1, rate = c(death_rate, 10000-death_rate), group = c(2,1))
death_rate = 239
rates3 = data.frame(x = 1, rate = c(death_rate, 10000-death_rate), group = c(2,1))
labels = c('238.78 per 10,000',
           '238 per 10,000',
           '239 per 10,000')
rates = bind_rows(rates1, rates2, rates3, .id='facet') %>%
  mutate(facetc = factor(facet, levels=1:3, labels=labels))

# 
colours = c("cadetblue3","hotpink")
bplot = ggplot(data = rates, aes(fill = factor(group), y = rate, x=x)) + 
  geom_bar(stat="identity")+
  scale_fill_manual(NULL, values = colours)+
  xlab(NULL)+
  scale_x_continuous(expand=c(0,0), breaks=NULL)+
  scale_y_continuous(expand=c(0,0))+
  ylab('Death rate')+
  theme_bw()+
  theme(axis.text.y = element_text(colour = 'white'),
        axis.title.y = element_text(colour = 'white'),
        plot.background = element_rect(fill='black', colour='transparent'), # transparent removes lines around plot
        legend.position = 'none')+
  facet_wrap(~facetc)

ggsave(filename = 'figures/death_rates.jpg', plot = bplot, width = 5, height = 4, units = 'in', dpi = 500, bg='transparent')
