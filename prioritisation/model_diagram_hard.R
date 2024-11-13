# model_diagram_hard.R
# model diagram, hard version for funding
# November 2024
library(diagram)

# labels
l1 = 'Funding' 
l2 = 'Benefits' 
l3 = 'Luck' 
l4 = 'Experience' 
l5 = 'Field' 
l6 = 'Amount' 
l7 = 'Institution' 
null = ''
labels = c(l1, l2, l3, l4, l5, l6, l7)
n.labels = length(labels)

#
### make data frame of box chars
# box.prop = length/width ratio, so > 1 = tall and thin
frame = read.table(sep='\t', stringsAsFactors=F, skip=0, header=T, text='
i	x	y	box.col	box.type	box.prop	box.size
1	0.25	0.6	cyan	square	0.42	0.08
2	0.85	0.6	orange	square	0.42	0.08
3	0.55	0.4	white	square	0.72	0.045
4	0.15	0.35	white	square	0.42	0.07
5	0.15	0.9	white	square	0.22	0.09
6	0.45	0.1	white	square	0.72	0.045
7	0.24	0.1	white	square	0.42	0.07')
# positions:
pos = as.matrix(subset(frame, select=c(x, y)))
# joins between boxes
M = matrix(nrow = nrow(frame), ncol = nrow(frame), byrow = TRUE, data = 0)
M[2, 1] = "' '"
M[3, 1] = "' '"
M[2, 3] = "' '"
M[2, 5] = "' '"
M[1, 4] = "' '"
M[1, 5] = "' '" # field to funding
M[6, 1] = "' '" # funding to amount
M[2, 6] = "' '" # amount to impact
M[6, 4] = "' '" # experience to impact
M[2, 4] = "' '" # experience to amount
M[2, 7] = "' '" # Institution to impact
M[1, 7] = "' '" # Institution to funding

## make figure 
par(mai=c(0,0.04,0.04,0.04), bg='transparent')

