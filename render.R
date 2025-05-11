# render.R
# trying to make handouts
# May 2025
library(quarto)
library(pagedown)
quarto_location = 'C:/Program Files/RStudio/resources/app/bin/quarto/bin'

# not working in html or pdf, slides look terrible!
quarto::quarto_render(input = "AIS/slides.qmd", 
                      execute = TRUE,
                      output_format = 'pdf',
                      output_file = 'slides_handout.pdf')

pagedown::chrome_print(input = "slides_handout.html", 
                       options = 
                         list(
                           printBackground = FALSE,
                           preferCSSPageSize = FALSE, 
                           paperWidth = 8.3, paperHeight = 11.7, 
                           marginTop = 0.1, marginBottom = 0.1, 
                           marginLeft = 0.1, marginRight = 0.1))
