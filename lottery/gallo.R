# gallo.R
# ANOVA results from https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0165147
# December 2021
library(ggplot2)
library(dplyr)

#
pdata = read.table(header=TRUE, sep=',', text='
source,variance,col,name
1,22.9,1,darkorange
2,77.1,2,skyblue') 

# plot
plot = ggplot(data=pdata, aes(x=source, y=variance, fill=factor(col)))+
  geom_bar(stat='identity')+
  scale_fill_manual(values=pdata$name)+
  scale_x_continuous(breaks = 1:2, labels=c('Application','Reviewer\n+Noise'))+
  ylab('Source of variance')+
  xlab('')+
  theme_minimal()+
  theme(legend.position ='none',
        text = element_text(size=17))
plot

# export
jpeg('figures/gallo.jpg', width=5, height=4.5, units='in', res=500)
print(plot)
dev.off()
