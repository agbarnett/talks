# model_diagram_easy.R
# model diagram, easy version for antibiotics
# November 2024
library(diagram)

# labels 
l1 = 'Antibiotic' 
l2 = 'Side-effects' 
l3 = 'Take full\ncourse' 
l4 = 'Age' 
l5 = 'Genetics' 
l6 = 'Illness\nseverity' 
null = ''
labels = c(l1, l2, l3, l4, l5, l6)
n.labels = length(labels)

#
### make data frame of box chars
# box.prop = length/width ratio, so > 1 = tall and thin
frame = read.table(sep='\t', stringsAsFactors=F, skip=0, header=T, text='
i	x	y	box.col	box.type	box.prop	box.size
1	0.25	0.6	cyan	square	0.42	0.08
2	0.85	0.6	orange	square	0.42	0.08
3	0.55	0.35	white	square	0.82	0.045
4	0.15	0.3	white	square	0.82	0.04
5	0.15	0.9	white	square	0.32	0.09
6	0.45	0.1	white	square	0.35	0.08')
# positions:
pos = as.matrix(subset(frame, select=c(x, y)))
# joins between boxes
M = matrix(nrow = nrow(frame), ncol = nrow(frame), byrow = TRUE, data = 0)
M[2, 1] = "' '"
M[3, 1] = "' '"
M[2, 3] = "' '"
M[2, 5] = "' '"
M[2, 4] = "' '"
M[3, 4] = "' '"
M[2, 6] = "' '"
M[3, 6] = "' '"

## make figure 
jpeg('figures/model_easy.jpg', width=6, height=4.75, units='in', res=400, quality=100, bg='transparent')
par(mai=c(0,0.04,0.04,0.04), bg='transparent')
plotmat(M, pos = pos, name = labels, lwd = 1, shadow.size=0, curve=0, arr.pos = 0.45,
        box.lwd = 2, cex.txt = 1, box.size = frame$box.size, box.col=frame$box.col,
        box.type = frame$box.type, box.prop = frame$box.prop, txt.col = 'black', lcol='grey88')
text(0.5, 0.65, 'Days', col='black')
dev.off()