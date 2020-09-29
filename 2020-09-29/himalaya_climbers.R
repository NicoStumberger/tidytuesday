# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2020-09-22')
tuesdata <- tidytuesdayR::tt_load(2020, week = 39)


peaks <- tuesdata$peaks

members <- tuesdata$members

expeditions <- tuesdata$expeditions

# Brainstorming
# Total de picos y altura, clasificacion por pico escalado vs no escalado
# Expeditions: tiempo medio de expedicion, maximo y minimo en algunos picos
# Expeditions: muertes por expedicion, por pico. Picos mas mortales. tamano de la expedicion (num de personas)
# Sexo o edad promedio, ppales causas de muerte. Altura mas comun de muerte. Lesion mas comun. altura mas comun por lesion