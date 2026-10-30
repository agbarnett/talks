# plot_states.R
# simple diagram to show state space model for immortal time
# October 2026

library(diagram)
names = c('Treated','Untreated','Dead')
M <- matrix(nrow = 3, ncol = 3, byrow = TRUE, data = 0)
M[1,2] = "' '"
M[3,1] = "' '"
M[3,2] = "' '"
jpeg('figures/states.jpg', width = 7, height = 5, units = 'in', res = 400, bg = 'transparent')
par(mai = c(0,0,0,0), bg='grey33')
plotmat(M, pos = c(1, 2), name = names, lwd = 1, curve = 0,
          box.lwd = 0.1, cex.txt = 1, box.size = 0.15, shadow.col = 'darkseagreen4',
        box.col = 'darkseagreen1', box.cex = 1.75, # increase text size inside boxes
          box.type = "square", box.prop = 0.5)
dev.off()
