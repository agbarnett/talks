# draw_confounder.R
# drawing confounders, causal pathways, etc
# Jan 2026
library(diagram)


### first figure: confounder ###
labels = c('Confounder:\nSeason','Exposure:\nTemperature','Outcome:\nDeath')

#
### make data frame of box chars
# box.prop = length/width ratio, so > 1 = tall and thin
frame = read.table(sep='\t', stringsAsFactors=F, skip=0, header=TRUE, text='
i	x	y	box.col	box.type	box.prop	box.size
1	0.15	0.15	grey77	square	0.7	0.12
2	0.5	0.85	palegreen	square	0.7	0.12
3	0.85	0.15	lightpink	square	0.7	0.12
')
# positions:
pos = as.matrix(subset(frame, select=c(x, y)))
# joins between boxes
M = matrix(nrow = nrow(frame), ncol = nrow(frame), byrow = TRUE, data = 0)
M[2, 1] = "' '"
M[3, 1] = "' '"
M[3, 2] = "' '"

## make figure 
jpeg('figures/confounders1.jpg', width=5, height=4, units='in', res=400, quality = 100)
par(mai=c(0,0.04,0.04,0.04))
plotmat(M, pos = pos, name = labels, lwd = 1, shadow.size=0, curve=0, arr.pos = 0.5,
        box.lwd = 2, cex.txt = 1, box.size = frame$box.size, box.col=frame$box.col,
        box.type = frame$box.type, box.prop = frame$box.prop, txt.col = 'black')
dev.off()


### second figure: strong predictor ###
labels = c('Confounder:\nSeason','Exposure:\nTemperature','Outcome:\nDeath','Smoker')

#
### make data frame of box chars
# box.prop = length/width ratio, so > 1 = tall and thin
frame = read.table(sep='\t', stringsAsFactors=F, skip=0, header=TRUE, text='
i	x	y	box.col	box.type	box.prop	box.size
1	0.15	0.5	grey77	square	0.7	0.12
2	0.5	0.85	palegreen	square	0.7	0.12
3	0.85	0.5	lightpink	square	0.7	0.12
4	0.5	0.15	grey77	square	0.7	0.12
')
# positions:
pos = as.matrix(subset(frame, select=c(x, y)))
# joins between boxes
M = matrix(nrow = nrow(frame), ncol = nrow(frame), byrow = TRUE, data = 0)
M[2, 1] = "' '"
M[3, 1] = "' '"
M[3, 2] = "' '"
M[3, 4] = "' '"

## make figure 
jpeg('figures/confounders1b.jpg', width=5, height=4, units='in', res=400, quality = 100)
par(mai=c(0,0.04,0.04,0.04))
plotmat(M, pos = pos, name = labels, lwd = 1, shadow.size=0, curve=0, arr.pos = 0.5,
        box.lwd = 2, cex.txt = 1, box.size = frame$box.size, box.col=frame$box.col,
        box.type = frame$box.type, box.prop = frame$box.prop, txt.col = 'black')
dev.off()


### third figure: over-adjusting ###
labels = c('Confounder:\nSeason','Exposure:\nTemperature','Outcome:\nDeath','Atmospheric\npressure')

### make data frame of box chars
# box.prop = length/width ratio, so > 1 = tall and thin
frame = read.table(sep='\t', stringsAsFactors=F, skip=0, header=TRUE, text='
i	x	y	box.col	box.type	box.prop	box.size
1	0.25	0.15	grey77	square	0.7	0.12
2	0.6	0.85	palegreen	square	0.7	0.12
3	0.85	0.15	lightpink	square	0.7	0.12
4	0.15	0.6	grey77	square	0.7	0.12
')
# positions:
pos = as.matrix(subset(frame, select=c(x, y)))
# joins between boxes
M = matrix(nrow = nrow(frame), ncol = nrow(frame), byrow = TRUE, data = 0)
M[2, 1] = "' '"
M[3, 1] = "' '"
M[3, 2] = "' '"
M[2, 4] = "' '"
M[4, 1] = "' '"

## make figure 
jpeg('figures/confounders2.jpg', width=5, height=4, units='in', res=400, quality = 100)
par(mai=c(0,0.04,0.04,0.04))
plotmat(M, pos = pos, name = labels, lwd = 1, shadow.size=0, curve=0, arr.pos = 0.5,
        box.lwd = 2, cex.txt = 1, box.size = frame$box.size, box.col=frame$box.col,
        box.type = frame$box.type, box.prop = frame$box.prop, txt.col = 'black')
dev.off()

### fourth figure: causal pathway ###
labels = c('Confounder:\nSeason','Exposure:\nTemperature','Outcome:\nDeath','Flu')

### make data frame of box chars
# box.prop = length/width ratio, so > 1 = tall and thin
frame = read.table(sep='\t', stringsAsFactors=F, skip=0, header=TRUE, text='
i	x	y	box.col	box.type	box.prop	box.size
1	0.15	0.15	grey77	square	0.7	0.12
2	0.5	0.85	palegreen	square	0.7	0.12
3	0.85	0.15	lightpink	square	0.7	0.12
4	0.5	0.15	grey77	square	0.7	0.12
')
# positions:
pos = as.matrix(subset(frame, select=c(x, y)))
# joins between boxes
M = matrix(nrow = nrow(frame), ncol = nrow(frame), byrow = TRUE, data = 0)
M[2, 1] = "' '"
M[3, 1] = "' '"
M[3, 2] = "' '"
M[3, 4] = "' '"
M[4, 1] = "' '"

## make figure 
jpeg('figures/confounders2b.jpg', width=5, height=4, units='in', res=400, quality = 100)
par(mai=c(0,0.04,0.04,0.04))
plotmat(M, pos = pos, name = labels, lwd = 1, shadow.size=0, curve=0, arr.pos = 0.5,
        box.lwd = 2, cex.txt = 1, box.size = frame$box.size, box.col=frame$box.col,
        box.type = frame$box.type, box.prop = frame$box.prop, txt.col = 'black')
dev.off()


### fifth figure: adjusting for future ###
labels = c('Confounder:\nSeason','Exposure:\nTemperature','Outcome:\nAdmitted','Length\nof stay')

### make data frame of box chars
# box.prop = length/width ratio, so > 1 = tall and thin
frame = read.table(sep='\t', stringsAsFactors=F, skip=0, header=TRUE, text='
i	x	y	box.col	box.type	box.prop	box.size
1	0.15	0.15	grey77	square	0.7	0.12
2	0.33	0.85	palegreen	square	0.7	0.12
3	0.5	0.15	lightpink	square	0.7	0.12
4	0.85	0.15	grey77	square	0.7	0.12
')
# positions:
pos = as.matrix(subset(frame, select=c(x, y)))
# joins between boxes
M = matrix(nrow = nrow(frame), ncol = nrow(frame), byrow = TRUE, data = 0)
M[2, 1] = "' '"
M[3, 1] = "' '"
M[3, 2] = "' '"
M[4, 3] = "' '"

## make figure 
jpeg('figures/confounders3.jpg', width=5, height=4, units='in', res=400, quality = 100)
par(mai=c(0,0.04,0.04,0.04))
plotmat(M, pos = pos, name = labels, lwd = 1, shadow.size=0, curve=0, arr.pos = 0.5,
        box.lwd = 2, cex.txt = 1, box.size = frame$box.size, box.col=frame$box.col,
        box.type = frame$box.type, box.prop = frame$box.prop, txt.col = 'black')
dev.off()

