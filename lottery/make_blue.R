# make_blue.R
# make four shades of blue
# December 2021
library(ggplot2)
library(dplyr)

#
pdata = read.table(header=TRUE, sep=',', text='
x,y,col,name
1,1,1,skyblue
1,2,2,dodgerblue
2,1,3,royalblue
2,2,4,navy') %>%
  mutate(col = factor(col))

# plot
plot = ggplot(data=pdata, aes(x=x, y=y, label=name))+
  geom_tile(aes(fill=col))+
  geom_text(col='white', size=8)+
  theme_void()+
  scale_fill_manual(values=pdata$name)+
  theme(legend.position ='none')
plot

# export
jpeg('figures/blues.jpg', width=5, height=4.5, units='in', res=500)
print(plot)
dev.off()
