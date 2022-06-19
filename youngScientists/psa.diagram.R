# psa.diagram.R
# June 2018
# p-values diagram
library(diagram)

## functions
# for formatting numbers
format_num = function(num){
  format(round(num), big.mark=',', scientific =FALSE)
}
#
draw_diagram = function(outfile, M, sizes, pos, names, colours, show_negative=TRUE){
  jpeg(outfile, width=8, height=7, units='in', res=300, quality = 100)
  par(mai=rep(0.05,4), xpd=T)
  plotmat(M, pos = pos, name = names, curve=0, lwd = 1, arr.lwd=2, shadow.size=0, 
          box.col = colours, 
          box.lwd = 2, box.size = sizes, box.cex=1.7, # increase text size in boxes
          box.type = "square", box.prop = 0.43, arr.pos=0.5)
  # type 2 (power)
  text(x=(0.5+0.9)/2, y=0.65, power, cex=1.8)
  text(x=(0.5+0.9)/2, y=0.85, 1-power, cex=1.8)
  # type 1
  if(show_negative==TRUE){
    text(x=(0.5+0.9)/2, y=0.15, alpha, cex=1.8)
    text(x=(0.5+0.9)/2, y=0.35, 1-alpha, cex=1.8)
  }
  dev.off()
}


# key parameters 
n.exp = 100000 # number of experiments
H1 =  125 / 100000 # prevalence of prostate cancer, from PMC2706483
H0 = 1 - H1
alpha = 1 - 0.91 # 1 - specificity, PMC3392481
power = 0.21 # sensitivity, PMC3392481

## diagram parameters that do not change
colours = c('white','white','white','light blue','white','light blue','white')
n.states = 7
# position, always the same
pos = matrix(ncol=2, byrow=T, data=c(
  0.11, 0.5,
  0.5, 0.25,
  0.5, 0.75,
  0.89, 0.15,
  0.89, 0.35,
  0.89, 0.65,
  0.89, 0.85))

### Step 1, just positive predictive value
names = c('',
          '',
          '\ndiseased',
          '',
          '',
          '\ntrue positive',
          '\nfalse positive')

# connections
M <- matrix(nrow = n.states, ncol = n.states, byrow = TRUE, data = 0)
M[6,3] = "' '"
M[7,3] = "' '"

# boxes
colours = c('white','white','white','light blue','white','light blue','white')
sizes = c(0,0,0.115,0,0,0.115,0.115)

# 
draw_diagram(outfile = 'figures/psa_journey1.jpg', 
             pos = pos, 
             sizes = sizes,
             M = M, 
             colours = colours,
             names = names,
             show_negative = FALSE)


### Step 2, add positive predictive value
names = c('',
          '\nhealthy',
          '\ndiseased',
          '\nfalse positive',
          '\ntrue negative',
          '\ntrue positive',
          '\nfalse positive')

# connections
M <- matrix(nrow = n.states, ncol = n.states, byrow = TRUE, data = 0)
M[4,2] = "' '"
M[5,2] = "' '"
M[6,3] = "' '"
M[7,3] = "' '"

# boxes
sizes = c(0,0.115,0.115,0.115,0.115,0.115,0.115)

# 
draw_diagram(outfile = 'figures/psa_journey2.jpg', 
             pos = pos, 
             sizes = sizes,
             M = M, 
             colours = colours,
             names = names,
             show_negative = TRUE)

### Step 3, add numbers for diseased
names = c(paste(format_num(n.exp), '\npatients', sep=''),
        '\nhealthy', 
        paste(format_num(n.exp*(1-H0)), '\ndiseased', sep=''),
        '\nfalse negative',
        '\ntrue negative',
        paste(format_num(n.exp*(1-H0)*power), '\ntrue positive', sep=''),
        paste(format_num(n.exp*(1-H0)*(1-power)), '\nfalse positive', sep=''))

# connections
M <- matrix(nrow = n.states, ncol = n.states, byrow = TRUE, data = 0)
M[2,1] = "' '"
M[3,1] = "' '"
M[4,2] = "' '"
M[5,2] = "' '"
M[6,3] = "' '"
M[7,3] = "' '"

# boxes
sizes = rep(0.115, n.states)

# 
draw_diagram(outfile = 'figures/psa_journey3.jpg', 
             pos = pos, 
             sizes = sizes,
             M = M, 
             colours = colours,
             names = names,
             show_negative = TRUE)

### Step 4, all numbers
names = c(paste(format_num(n.exp), '\npatients', sep=''),
          paste(format_num(n.exp*H0), '\nhealthy', sep=''),
          paste(format_num(n.exp*(1-H0)), '\ndiseased', sep=''),
          paste(format_num(n.exp*H0*alpha), '\nfalse negative', sep=''),
          paste(format_num(n.exp*H0*(1-alpha)), '\ntrue negative', sep=''),
          paste(format_num(n.exp*(1-H0)*power), '\ntrue positive', sep=''),
          paste(format_num(n.exp*(1-H0)*(1-power)), '\nfalse positive', sep=''))

# connections
M <- matrix(nrow = n.states, ncol = n.states, byrow = TRUE, data = 0)
M[2,1] = "' '"
M[3,1] = "' '"
M[4,2] = "' '"
M[5,2] = "' '"
M[6,3] = "' '"
M[7,3] = "' '"

# boxes
sizes = rep(0.115, n.states)

# 
draw_diagram(outfile = 'figures/psa_journey4.jpg', 
             pos = pos, 
             sizes = sizes,
             M = M, 
             colours = colours,
             names = names,
             show_negative = TRUE)

#### Section 2: p-values ####
#
n.exp = 200 # number of experiments
H0 = 0.9 # null true
alpha = 0.05
power = 0.6
#
names=c(paste(n.exp, '\nexperiments', sep=''),
        paste(n.exp*H0, '\nno effect', sep=''),
        paste(n.exp*(1-H0), '\nreal effect', sep=''),
        paste(n.exp*H0*alpha, '\nfalse null', sep=''),
        paste(n.exp*H0*(1-alpha), '\n true null', sep=''),
        paste(n.exp*(1-H0)*power, '\nfound', sep=''),
        paste(n.exp*(1-H0)*(1-power), '\n not found', sep=''))
# 
draw_diagram(outfile = 'figures/pval_journey.jpg', 
             pos = pos, 
             sizes = sizes,
             M = M, 
             colours = colours,
             names = names,
             show_negative = TRUE)
