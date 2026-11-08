# plot_curves.R
# plot two survival curves that show how ignoring time can be important
# initial code from copilot
library(survival)
library(survminer)
library(ggplot2)
set.seed(123)
n <- 100

# Rapid death group: deaths occur early
rapid_event_times <- c(
  runif(70, 0, 3), # deaths concentrated early
  runif(30, 8.1, 8.3) # censored observations
)

rapid_status <- c(rep(1, 70), rep(0, 30))

# Slow death group: deaths occur late
slow_event_times <- c(
  runif(70, 1, 8), # deaths concentrated late
  runif(30, 8.1, 8.3) # censored observations
)

slow_status <- c(rep(1, 70), rep(0, 30))

# Combine data
dat <- data.frame(
  time = c(rapid_event_times, slow_event_times),
  status = c(rapid_status, slow_status),
  group = factor(
    c(rep(1, n), rep(2, n)) # rapid and slow
  )
)

# Kaplan-Meier curves
fit <- survfit(Surv(time, status) ~ group, data = dat)

# nice plot
colours = c('khaki1', 'firebrick')
bcolor = 'grey72' # #98F5FF"
splot = ggsurvplot(
  fit,
  data = dat,
  risk.table = FALSE,
  conf.int = FALSE,
  censor = FALSE,
  pval = FALSE,
  palette = colours,
  legend = 'none',
  xlab = "Time",
  ylab = "Survival probability",
  break.time.by = 2,
  xlim = c(0, 8.3),
  surv.scale = "percent",
  ggtheme = theme_bw(base_size = 14)
)

# text
text1 = data.frame(x = 7, y = 0.15, text = 'Logistic\nregression')
text2 = data.frame(x = 3.5, y = 0.55, text = 'Survival\nanalysis')

# redo plot
splot1 = splot$plot +
  scale_x_continuous(expand = 0) +
  scale_y_continuous(expand = 0.005) +
  scale_color_manual(NULL, values = colours) +
  geom_segment(
    aes(x = 3.5, xend = 3.5, y = 0.3, yend = 0.75),
    arrow = arrow(length = unit(0.2, "cm"), type = "closed", ends = 'both')
  ) + # arrows and text
  geom_segment(
    aes(x = 7, xend = 7, y = 0, yend = 0.3),
    arrow = arrow(length = unit(0.2, "cm"), type = "closed", ends = 'both')
  ) + # arrows and text
  geom_label(
    data = text1,
    aes(x = x, y = y, label = text),
    fill = bcolor,
    size = 4
  ) +
  geom_label(
    data = text2,
    aes(x = x, y = y, label = text),
    fill = bcolor,
    size = 4
  ) +
  theme(
    legend.position = "inside",
    legend.position.inside = c(0.8, 0.85),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = 'grey'),
    legend.background = element_rect(fill = bcolor),
    plot.background = element_rect(fill = bcolor),
    panel.background = element_rect(fill = bcolor)
  )

# export
ggsave(
  filename = 'figures/two_curves.jpg',
  plot = splot1,
  width = 5.1,
  height = 4.5,
  units = 'in',
  dpi = 400
)
