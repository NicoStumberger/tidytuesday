library(tidyverse)

hotels <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-11/hotels.csv')

hotels %>% 
        ggplot(aes(hotel)) +
        geom_bar(alpha = 0.6) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Las canceladas son mayormente del City Hotel
hotels %>% 
        ggplot(aes(factor(is_canceled))) +
        geom_bar(aes(fill = hotel))

# City Hotel es el que tiene un problema mayor con las canceladas
hotels %>% 
        ggplot(aes(hotel)) +
        geom_bar(aes(fill = factor(hotels$is_canceled)))

# Reservas del último minuto, no se cancelan
hotels %>% 
        ggplot(aes(factor(is_canceled), lead_time)) +
        geom_violin()

# La mayoría de las reservas se hicieron en el último min
hotels %>% 
        ggplot(aes(lead_time)) +
        geom_histogram(aes(y = ..density..), alpha = 0.6, bins = 20) +
        geom_density(aes(y = ..density..), color = "blue") +
        geom_rug()

# Más reservas en 2016 que 2015...
hotels %>% 
        ggplot(aes(arrival_date_year)) +
        geom_bar(alpha = 0.6)

# Muchas mas reservas en verano que en invierno
hotels %>% 
        ggplot(aes(arrival_date_month)) + #cómo ordenar los meses?
        geom_bar(alpha = 0.5) +
        coord_flip()

# Las reservas son claramente estacionales
hotels %>% 
        ggplot(aes(arrival_date_week_number)) +
        geom_bar(alpha = 0.5) +
        facet_wrap(~ arrival_date_year, ncol = 1)
# Este grafico es interesante: solo hay info desde mediados de 2015 y hasta
# un poco más de mediados de 2017. 
# 2016 es el único año completo

# El día del mes no me dice mucho..
hotels %>% 
        ggplot(aes(arrival_date_day_of_month)) +
        geom_bar(alpha = 0.5)
# Deberia crear un nuevo feature de fecha para incluir dummy finde vs no finde:
# q el finde sea noche de viernes y sabado.


hotels %>% 
        ggplot(aes(adults)) +
        geom_bar()

# Country convertir a país real
# Sumar children y babies
# Crear una dummy para single o acompañado

# No tiene muchos clientes frecuentes
hotels %>% 
        ggplot(aes(factor(is_repeated_guest))) +
        geom_bar()

hotels %>% 
        ggplot(aes(previous_cancellations)) +
        geom_histogram()

# No me dice nada
hotels %>% 
        ggplot(aes(factor(is_canceled), booking_changes)) +
        geom_boxplot() +
        scale_y_log10()

# No me dice nada...
hotels %>% 
        ggplot(aes(factor(is_canceled))) +
        geom_bar() +
        facet_wrap(~ deposit_type)

# Demasiados, habría que agruparlos..
hotels %>% 
        ggplot(aes(company)) +
        geom_bar()


