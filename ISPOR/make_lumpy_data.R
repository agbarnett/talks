# make_lumpy_data.R
# compare a normal distribution with interesting data
# August 2024
library(ggplot2)
library(dplyr)

# smooth
n = 3000
data1 = data.frame(x = rnorm(n, mean=0, sd=1))
# lumpy
data2 = data.frame(y = sample(c(-2.5,-1,0,1.5), size=n, replace=TRUE)) %>%
  mutate(x = rnorm(n(), mean=y, sd=0.5))
# concatenate
to_plot = bind_rows(data1, data2, .id = 'group') %>%
  mutate(want = ifelse(group==1, 'What researchers *actually* want','What researchers *should* want'))

# 
gplot = ggplot(to_plot, aes(x = x, fill=factor(want))) +
  geom_histogram()+
  scale_fill_manual(values = c('darkorange2','skyblue'))+
  facet_wrap(~want, ncol = 2)+
  ylab('Count')+
  xlab('')+
  theme_bw()+
  scale_x_continuous(breaks=c(-2,0,2), labels=NULL)+
  theme(legend.position = 'none',
        panel.grid.minor = element_blank())
gplot

ggsave('figures/lumpy.jpg', gplot, width=6.7, height=4, units='in', dpi=450)
