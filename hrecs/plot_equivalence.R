# plot_equivalence.R
# CIs to show equivalence
# got copilot to give a start
# October 2026

#
df <- data.frame(
  scenario = 1:4,
  slabel = c(
    "Inconclusive",
    "Different",
    "Equivalent",
    "Equivalent"
  ),
  estimate = c(0, 11.5, 1, 3),
  lower = c(-12.3, 6.5, -3, 1),
  upper = c(12.3, 16.5, 5, 5)
)

# plus/minus 10% for equivalence
eq_margin <- 10
#
mtext = data.frame(x = 0, y = 0.5, text = 'Equivalence margin')
bcolor = 'grey66' # to match slide

eplot = ggplot(df, aes(y = scenario, x = estimate)) +
  geom_rect(
    aes(xmin = -eq_margin, xmax = eq_margin, ymin = -Inf, ymax = Inf),
    inherit.aes = FALSE,
    fill = "lightgreen",
    alpha = 0.15
  ) +
  geom_vline(
    xintercept = c(-eq_margin, eq_margin),
    linetype = "dotted",
    colour = "darkgreen"
  ) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_segment(
    aes(x = -10, xend = 10, y = 0.5, yend = 0.5),
    arrow = arrow(
      length = unit(0.3, "cm"), # Size of the arrowhead
      angle = 30, # Angle of the arrowhead (sharper vs wider)
      ends = "both", # "last", "first", or "both"
      type = "closed" # "open" (v-shape) or "closed" (filled triangle)
    )
  ) +
  geom_label(
    data = mtext,
    aes(x = x, y = y, label = text),
    col = 'black',
    fill = 'lightgreen'
  ) +
  geom_errorbarh(
    aes(xmin = lower, xmax = upper),
    height = 0.15,
    linewidth = 1.2
  ) +
  geom_point(size = 3) +
  labs(
    x = "Treatment difference (%)",
    y = "",
    title = NULL
  ) +
  scale_y_reverse(breaks = 1:4, labels = df$slabel) +
  theme_minimal(base_size = 14) +
  theme(
    plot.background = element_rect(fill = bcolor),
    panel.background = element_rect(fill = bcolor),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )


eplot

ggsave(
  filename = 'figures/equivalence.jpg',
  plot = eplot,
  width = 5.2,
  height = 4,
  units = 'in',
  dpi = 400
)
