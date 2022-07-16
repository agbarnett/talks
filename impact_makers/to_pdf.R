# make PDF version
library(renderthis)
chrome_on_my_pc = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe"
Sys.setenv(PAGEDOWN_CHROME = chrome_on_my_pc)
Sys.setenv(CHROMOTE_CHROME = chrome_on_my_pc)
to_pdf(from = "slides.Rmd")

