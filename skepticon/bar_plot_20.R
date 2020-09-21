# bar_plot_20.R
# bar plots that show 20:80 split
# september 2020
library(ggplot2)
library(dplyr)
library(gridExtra)

# data 1, uniform
data1 = data.frame(x=seq(0,9,1), y=1) %>%
  mutate(col = as.numeric(x <= 1)+1,
         col = factor(col))
# data 2, v-shape
data2 = data.frame(x=seq(0,9,1), y=c(1.5,0.5,seq(0.25,1.75,length.out=8))) %>%
  mutate(col = as.numeric(x <= 1)+1,
         col = factor(col))
# data 3, n-shape
data3 = data.frame(x=seq(0,9,1), y=c(0.5,1.5,seq(1.75,0.25,length.out=8))) %>%
  mutate(col = as.numeric(x <= 1)+1,
         col = factor(col))
# data 4, gap
data4 = data.frame(x=c(0,3,4,5,6,7,8,9), y=c(2,rep(8/7,7))) %>%
  mutate(col = as.numeric(x <= 1)+1,
         col = factor(col))

# function to make the same plot
bplot = function(indata){
b_plot = ggplot(data=indata, aes(x=x, y=y, fill=col))+
  geom_bar(stat='identity')+
  theme_bw()+
  scale_fill_manual(NULL, values=c(c("#EE3A8C", "#8DB6CD")))+
  scale_x_continuous(breaks=seq(0,9,1), expand = c(0.02,0.02), labels=NULL)+
  scale_y_continuous(limits=c(0,2.3), expand = c(0.02,0.02), labels=NULL)+
  xlab('')+
  ylab('')+
  geom_text(x=0.5,y=2.15, label='20%', col="#8DB6CD")+
  geom_text(x=5.5,y=2.15, label='80%', col="#EE3A8C")+
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        axis.ticks = element_blank(), # remove tick marks
        legend.position = 'none')
return(b_plot)
}
bplot1 = bplot(data1)
bplot2 = bplot(data2)
bplot3 = bplot(data3)
bplot4 = bplot(data4)

grid.arrange(bplot1, bplot2, bplot3, bplot4)

jpeg('figures/malnutrition.jpg', width=4.5, height=3, units='in', res=400, quality=100, bg='transparent')
grid.arrange(bplot1, bplot2, bplot3, bplot4)
dev.off()
