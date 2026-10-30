# plot_immortal.R
# simple diagram to show immortal time bias
# used co-pilot
# October 2026

dat <- data.frame(
  patient = c("A", "B", "C", "D"),
  start = 0,
  end = c(10, 10, 10, 10),
  treat = c(6, 4, NA, NA),
  death = c(10, 10, 3, 7)
)

treated <- subset(dat, !is.na(treat))
untreated <- subset(dat, is.na(treat))

iplot = ggplot() +

  # Immortal time (orange)
  geom_segment(
    data = treated,
    aes(
      x = start,
      xend = treat,
      y = patient,
      yend = patient,
      colour = "Immortal\ntime"
    ),
    linewidth = 2
  ) +

  # Treated time (blue)
  geom_segment(
    data = treated,
    aes(
      x = treat,
      xend = end,
      y = patient,
      yend = patient,
      colour = "Treated\ntime"
    ),
    linewidth = 2
  ) +

  # Never-treated patients
  geom_segment(
    data = untreated,
    aes(
      x = start,
      xend = death,
      y = patient,
      yend = patient,
      colour = "Untreated\nfollow-up"
    ),
    linewidth = 2
  ) +

  # Treatment starts
  geom_point(
    data = treated,
    aes(
      x = treat,
      y = patient,
      shape = "Treatment\nstarts"
    ),
    size = 4
  ) +

  # Death
  geom_point(
    data = dat,
    aes(
      x = death,
      y = patient,
      shape = "Death"
    ),
    size = 4,
    stroke = 1.5
  ) +

  annotate(
    "text",
    x = 2.3,
    y = 4.3,
    label = "Immortal time\n(must survive to treatment)",
    colour = "darkorange3"
  ) +

  scale_colour_manual(
    values = c(
      "Immortal\ntime" = "darkorange",
      "Treated\ntime" = "steelblue",
      "Untreated\nfollow-up" = "grey40"
    ),
    name = NULL
  ) +

  scale_shape_manual(
    values = c(
      "Treatment\nstarts" = 16,
      "Death" = 4
    ),
    name = NULL
  ) +

  labs(
    x = "Follow-up time",
    y = NULL,
    title = NULL
  ) +
  scale_x_continuous(labels = NULL) + # remove x-axis
  scale_y_discrete(limits = rev) + # reverse patient order
  theme_minimal(base_size = 14) +
  theme(
    # Eliminate the margin around the legend itself
    legend.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt"),
    # Eliminate the margin around the entire legend box container
    legend.box.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt"),
    plot.background = element_rect(fill = 'pink2'),
    panel.background = element_rect(fill = 'pink1'),
    legend.position = "bottom"
  )


# export
ggsave(
  filename = 'figures/immortal.jpg',
  plot = iplot,
  width = 6.5,
  height = 4.7,
  units = 'in',
  dpi = 400
)
