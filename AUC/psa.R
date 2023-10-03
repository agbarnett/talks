# psa.R
# stats for PSA test from large US study
# data from https://jamanetwork.com/journals/jama/fullarticle/201171
# September 2023

# rows = diagnosis, columns = truth (dre = digital rectal exam)
# using standard PSA cutoff of 4
dat = matrix(c(60,577,497,4453), nrow=2, byrow = TRUE)
dat
(sens = dat[1,1] / (dat[1,1]+dat[2,1]))
(spec = dat[2,2] / (dat[2,2]+dat[1,2]))
(ppv = dat[1,1] / (dat[1,1]+dat[1,2]))
(npv = dat[2,2] / (dat[2,1]+dat[2,2]))

# actually more about biopsies, so don't use these data!