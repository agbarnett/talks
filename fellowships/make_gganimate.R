# make_gganimate.R
# make animations for presentation
library(dplyr)
library(gganimate)
# set animation size
options(gganimate.dev_args = list(width = 500, height = 500))

### Animation 1: variance and spread ###

## generate data
n.dots = 50
# wide dots
x = runif(n.dots, min=0.01, max=0.99)
y = runif(n.dots, min=0.01, max=0.99)
colours = grey(runif(n.dots, min=0, max=1))
symbols = sample(15:18, replace=TRUE, size=n.dots )
frame1 = data.frame(x=x, y=y, col=colours, sd=3, shape=symbols)
# narrow dots
x = runif(n.dots, min=0.48, max=0.52)
y = runif(n.dots, min=0.48, max=0.52)
frame2 = data.frame(x=x, y=y, col=colours, sd=1, shape=symbols)
frames = bind_rows(frame1, frame2)
# Start with a static plot

p <- ggplot(frames, aes(x = x, y = y, col=col, shape=factor(shape)))+
  geom_point(size=8)+
  theme_bw()+
  scale_shape_manual(NULL, values=15:18)+
  theme(legend.position = 'none')+
  scale_y_continuous(breaks=NULL)+
  scale_x_continuous(breaks=NULL)+
  xlab('')+
  ylab('')

anim <- p +
  transition_states(sd,
                    transition_length = 2,
                    state_length = 1)
anim
anim_save(anim, filename="figures/variance_animation.gif")

### Animation 2: chance ### - not used

## generate data
n_changes = 5
n_people = 5
all_frames = NULL
for (p in 1:n_people){
  trajectory = c(0.5, sample(c(-0.5, 0.5), replace=TRUE, size=n_changes))
  frame = data.frame(x=0:n_changes, y=cumsum(trajectory), col=p)
  all_frames = bind_rows(all_frames, frame)
}
p <- ggplot(all_frames, aes(x = x, y = y, col=factor(col), group=factor(col)))+
  geom_point(size=3)+
  geom_line()+
  theme_bw()+
  theme(legend.position = 'none')+
  scale_y_continuous(breaks=NULL)+
  scale_x_continuous(breaks=NULL)+
  xlab('')+
  ylab('')

