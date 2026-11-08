# plot_dependence.R
# show a plot of the problems of not adjusting for dependence
# two plots, data from real study; correlation over time
# Nov 2026
library(ggplot2)
library(dplyr)
library(ggimage) # for inserting pictures

data = read.table(
  sep = ',',
  header = TRUE,
  text = 'mnum,model,b,se,t,lower,upper
1,regression,-0.4400,0.1254,-3.5075,-0.6920,-0.1880
2,mixed,-0.4525,0.1778,-2.5455,-0.8099,-0.0951'
)

#
bcolour = 'darkseagreen4'
colour = 'navy'
labels = c('Ignoring\ndependence', 'Allowing\ndependence')
plot = ggplot(data = data, aes(x = mnum, y = b, ymin = lower, ymax = upper)) +
  scale_x_reverse(expand = 0.05, breaks = 1:2, labels = labels) +
  geom_point(col = colour, size = 4) +
  geom_errorbar(width = 0, col = colour, size = 1.2) +
  xlab(NULL) +
  ylab('Difference in monitors') +
  coord_flip() +
  theme_bw() +
  theme(
    text = element_text(color = 'grey88'),
    axis.text = element_text(color = 'grey88'),
    axis.ticks = element_line(color = 'grey88'),
    plot.background = element_rect(fill = bcolour, colour = 'grey88'),
    panel.background = element_rect(fill = bcolour, colour = 'grey88'),
    panel.border = element_rect(fill = bcolour, colour = 'grey88'),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )
plot

# export
ggsave(
  filename = 'figures/dependence.jpg',
  plot = plot,
  width = 3.7,
  height = 2.4,
  units = 'in',
  dpi = 400
)

### second plot, correlation over time
ldata = NULL
for (s in 1:2) {
  for (t in 1:6) {
    y = s + rnorm(n = 1, sd = 0.25)
    f = data.frame(s = s, t = t, y = y)
    ldata = bind_rows(ldata, f)
  }
}

# data frame with pictures; downloaded from unsplash
pics = group_by(ldata, s) %>%
  summarise(t = max(t) + 0.8, y = mean(y)) %>%
  ungroup() %>%
  mutate(
    image_path = c(
      "figures/lucas-gouvea-aoEwuEH7YAs-unsplash.png",
      "figures/lucas-gouvea-vkCUpYy6xGU-unsplash.png"
    )
  )

# plot
colours = c('darkorange2', 'lightblue')
ldata = mutate(ldata, s = factor(s))
lplot = ggplot(data = ldata, aes(x = t, y = y, group = s, colour = s)) +
  geom_point(size = 4) +
  geom_line(size = 2) +
  scale_color_manual(NULL, values = colours) +
  ylab('Outcome') +
  xlab('Time') +
  theme_bw() +
  theme(
    legend.position = 'none',
    text = element_text(color = 'grey88'),
    axis.text = element_text(color = 'grey88'),
    axis.ticks = element_line(color = 'grey88'),
    plot.background = element_rect(fill = bcolour, colour = 'grey88'),
    panel.background = element_rect(fill = bcolour, colour = 'grey88'),
    panel.border = element_rect(fill = bcolour, colour = 'grey88'),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )
lplot.plus = lplot +
  geom_image(
    data = pics,
    aes(x = t, y = y, col = NULL, image = image_path),
    size = 0.2 # controls size of pictures
  )

# export
ggsave(
  filename = 'figures/correlation.png',
  device = 'png',
  plot = lplot.plus,
  width = 5.4,
  height = 3.5,
  units = 'in',
  dpi = 400
)
