library(tidyverse)
library(ggridges)
library(viridis)
library(hrbrthemes)
library(lubridate)
library(ggrepel)
library(extrafont)
loadfonts(device = "win")
library(hrbrthemes)


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


peaks %>% ggplot(aes(height_metres, 
                     group = climbing_status, 
                     fill = climbing_status)) +
        geom_density(bins = 30, alpha = 0.5)


skimr::skim(members)


expeditions_height <- expeditions %>%
        left_join(peaks, by = ("peak_id")) %>%
        select(
                peak_name.x,
                year,
                season,
                highpoint_date,
                termination_reason,
                highpoint_metres,
                height_metres
        ) %>% 
        mutate(month = month(highpoint_date, label = TRUE, abbr = TRUE))


expeditions_height %>% 
        ggplot(aes(x = highpoint_metres, y = month, fill = ..x..)) +
        geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
        scale_fill_viridis(name = "...", option = "C")


expeditions_height %>% 
        group_by(peak_name.x) %>% 
        summarise(n = n()) %>% 
        slice_max(n = 10, order_by = n)

members_height <- members %>% 
        left_join(expeditions) %>% 
        left_join(peaks) %>% 
        mutate(month = month(highpoint_date, label = TRUE, abbr = TRUE))



peaks_heigth <- peaks %>% 
        select(peak_name, height_metres)

top_peaks_by_month <- members_height %>%
        filter(!is.na(month)) %>%
        filter(success == "TRUE") %>%
        group_by(month, peak_name) %>%
        summarise(n = n()) %>%
        slice_max(n = 3, order_by = n) %>% 
        left_join(peaks_heigth)


# Mountain palette
#F1DAD3 naranja atardecer
#2C4F71 azul oscuro
#747E9A azul opaco
#C1C7DC celeste claro
#9FB3D3 celeste



#101118 negro
#5a5b62 gris amarronado
#ebecf0 claro
#c1c5d6 celeste
#787fa0 azul


#000010 negro
#4b5354 gris
#275ea3 azul
#9ecfe7 celeste
#e9edef gris claro

color_fondo <- "#e9edef"
color_titulo <- "#275ea3"
color_dens_low <- "#275ea3"
color_dens_high <- "white"

# Most succeded peaks by month
himalaya_ridge <- members_height %>%
        filter(!is.na(month)) %>%
        filter(success == "TRUE") %>%
        ggplot(aes(
                x = height_metres,
                y = reorder(month, desc(month)),
                fill = ..x..
        )) +
        geom_density_ridges_gradient(scale = 2, 
                                     rel_min_height = 0.01, 
                                     color = color_dens_high) +
        scale_fill_gradient(low = color_dens_low, high = color_dens_high) +
        # scale_fill_distiller(name = "Height") +
        geom_text_repel(data = top_peaks_by_month, nudge_y = 1,
                  aes(height_metres, month, label = peak_name)) +
        # scale_fill_viridis(name = "Height", option = "C") +
        scale_x_continuous(limits = c(5500, 9300)) +
        theme_dark() +
        theme(panel.grid.minor = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.major.y = element_blank(),
              legend.position = "none", 
              axis.text = element_text(color = color_titulo, size = 30),
              axis.title.x = element_text(colour = color_titulo, size = 30, hjust = 1),
              panel.background = element_rect(fill = color_fondo, 
                                              color = color_fondo),
              plot.background = element_rect(fill = color_fondo, 
                                             color = color_fondo),
              plot.title = element_text(color = color_titulo, 
                                   size = 50, 
                                   hjust = 0,
                                   vjust = 1,
                                   margin = margin(100,1,1,1)),
              plot.subtitle = element_text(color = color_titulo, 
                                           size = 30, 
                                           hjust = 0,
                                           vjust = 1,
                                           margin = margin(1,1,10,1)
                                           )
                                           ) +
        labs(title = "Most popular succeded Himalayean Peaks",
             subtitle = "by month",
             x = "Height in metres",
             y = "")

himalaya_ridge

ggsave(
        himalaya_ridge,
        filename = "2020-09-29/plots/himalaya.jpg",
        width = 20,
        height = 20,
        dpi = "screen",
        # esto permite renderizar extrafonts en pdf
        device = "jpeg"
)
                                



