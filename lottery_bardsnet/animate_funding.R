# animate_funding.R
# animate application being funded or not
# November 2022
library(dplyr)
library(gganimate)
library(gapminder)

# make the data
n_applications = 10 # number of applications to animate
applications = data.frame(app = 1:n_applications, score=0, time = 1, colour=1)

# number of bootstrap grant rounds


# loop through frames and add random noise
n_times = 5
all_frames = applications
for(k in 1:n_times){
  applications = mutate(applications, 
                        score = score + runif(n=n()),
                        time = time + 1)
  all_frames = bind_rows(all_frames, applications)
}
# colour winners
top_ten = quantile(applications$score, 0.90)
applications = mutate(applications, 
                      colour = ifelse(score > top_ten, 2, 1))
winner_colours = c('blue','red')

# make plot
plot = ggplot(all_frames, aes(x=score, y=time, label = app, colour = factor(colour))) +
  geom_point(size=8, alpha = 0.7, show.legend = FALSE) +
  geom_text(size=4, col='white', show.legend = FALSE) + # add application number
  scale_colour_manual(NULL, values = winner_colours) +
  theme_bw()+
  scale_y_continuous(breaks = NULL)+
  # gganimate specific bits
  transition_time(time) +
  ylab('')+
  xlab('Score')+
  ease_aes('linear')

# animate
animate(plot, end_pause = 10)



### part 2: simple bar plot
bar = data.frame(x=1:3, p=c(60,29,9), text=c('Never','Sometimes','Always'))
bplot = ggplot(data=bar, aes(x=x, y=p, label=text, fill=factor(x)))+
  geom_bar(position = 'stack', stat='identity')+
  geom_label(col='White', size=5)+
  scale_fill_manual(NULL, values=c('brown','grey22','goldenrod'))+
  theme_bw()+
  theme(panel.grid.minor = element_blank(),
          legend.position = 'none')+
  ylab('Percent')+
  xlab('')+
  scale_x_continuous(breaks=NULL)
bplot

jpeg('figures/barplot.jpg', width=6, height=4, units='in', res=400, quality=100)
print(bplot)
dev.off()
