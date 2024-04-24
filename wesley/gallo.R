# gallo.R
# ANOVA results from https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0165147
# update with NHMRC results from https://www.nhmrc.gov.au/about-us/leadership-and-governance/committees/peer-review-analysis-committee
# April 2024
library(ggplot2)
library(dplyr)

# from 2020 data in Table 12 on page 20
pdata = read.table(header=TRUE, sep=',', text='
level,source,variance,name
1,1,34.2,darkorange
1,2,19.7,skyblue
1,3,46.2,darkred
2,1,39.2,darkorange
2,2,17.0,skyblue
2,3,43.8,darkred') %>%
  mutate(level = factor(level, levels=1:2, labels=c('Emerging leadership','Leadership')))

# plot
plot = ggplot(data=pdata, aes(x=source, y=variance, fill=factor(source)))+
  geom_bar(stat='identity')+
  scale_fill_manual(values=pdata$name)+
  scale_x_continuous(breaks = 1:3, labels=c('Application','Reviewer','Noise'))+
  ylab('Source of variance')+
  xlab('')+
  theme_minimal()+
  facet_wrap(~level)+
  theme(legend.position ='none',
        panel.grid.minor = element_blank(),
        text = element_text(size=17))
plot

# export
jpeg('figures/nhmrc.jpg', width=6.5, height=4.75, units='in', res=500)
print(plot)
dev.off()
