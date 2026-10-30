# plot simple seasonal change

library(ggplot2)

# data
time = seq(0, 48, 0.1)
seas = cos(time * 2 * pi / 24)
frame = data.frame(time = time, seas = seas)

# label and arrow
label = data.frame(time = 36, seas = 0.5, label = 'Intervention\nhappens here')
arrow = data.frame(x = 36, y = 0.2, xend = 36, yend = -0.7)

# plot
bcolor2 = '#FFFACD' # lemonchiffon
bcolor1 = '#EEE9BF' # lemonchiffon2
splot = ggplot(data = frame, aes(x = time, y = seas)) +
  geom_line(size = 2) +
  theme_bw() +
  theme(
    plot.background = element_rect(fill = bcolor2),
    panel.background = element_rect(fill = bcolor1)
  ) +
  geom_text(data = label, aes(x = time, y = seas, label = label)) +
  geom_segment(
    data = arrow,
    aes(x = x, y = y, xend = xend, yend = yend),
    arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
    col = 'grey55'
  ) +
  scale_x_continuous(breaks = NULL) +
  scale_y_continuous(breaks = NULL) +
  xlab('Time') +
  ylab('Disease')

splot

ggsave(
  filename = 'figures/season.jpg',
  plot = splot,
  width = 4.5,
  height = 4,
  units = 'in',
  dpi = 400
)
