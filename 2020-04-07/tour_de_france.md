Tidytuesday: Tour de France
================
Nicolas Stumberger

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.0     v purrr   0.3.3
    ## v tibble  2.1.3     v dplyr   0.8.5
    ## v tidyr   1.0.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.4.0

    ## Warning: package 'ggplot2' was built under R version 3.6.3

    ## Warning: package 'dplyr' was built under R version 3.6.3

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

### 1\. Carga de datos

``` r
tdf_winners <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-07/tdf_winners.csv')
```

    ## Parsed with column specification:
    ## cols(
    ##   edition = col_double(),
    ##   start_date = col_date(format = ""),
    ##   winner_name = col_character(),
    ##   winner_team = col_character(),
    ##   distance = col_double(),
    ##   time_overall = col_double(),
    ##   time_margin = col_double(),
    ##   stage_wins = col_double(),
    ##   stages_led = col_double(),
    ##   height = col_double(),
    ##   weight = col_double(),
    ##   age = col_double(),
    ##   born = col_date(format = ""),
    ##   died = col_date(format = ""),
    ##   full_name = col_character(),
    ##   nickname = col_character(),
    ##   birth_town = col_character(),
    ##   birth_country = col_character(),
    ##   nationality = col_character()
    ## )

### 2\. EDA

``` r
glimpse(tdf_winners)
```

    ## Observations: 106
    ## Variables: 19
    ## $ edition       <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16...
    ## $ start_date    <date> 1903-07-01, 1904-07-02, 1905-07-09, 1906-07-04, 1907...
    ## $ winner_name   <chr> "Maurice Garin", "Henri Cornet", "Louis Trousselier",...
    ## $ winner_team   <chr> "La Française", "Conte", "Peugeot–Wolber", "Peugeot–W...
    ## $ distance      <dbl> 2428, 2428, 2994, 4637, 4488, 4497, 4498, 4734, 5343,...
    ## $ time_overall  <dbl> 94.55389, 96.09861, NA, NA, NA, NA, NA, NA, NA, NA, 1...
    ## $ time_margin   <dbl> 2.98916667, 2.27055556, NA, NA, NA, NA, NA, NA, NA, N...
    ## $ stage_wins    <dbl> 3, 1, 5, 5, 2, 5, 6, 4, 2, 3, 1, 1, 1, 4, 2, 0, 3, 4,...
    ## $ stages_led    <dbl> 6, 3, 10, 12, 5, 13, 13, 3, 13, 13, 8, 15, 2, 14, 14,...
    ## $ height        <dbl> 1.62, NA, NA, NA, NA, NA, 1.78, NA, NA, NA, NA, NA, N...
    ## $ weight        <dbl> 60, NA, NA, NA, NA, NA, 88, NA, NA, NA, NA, NA, NA, N...
    ## $ age           <dbl> 32, 19, 24, 27, 24, 25, 22, 22, 26, 23, 23, 24, 33, 3...
    ## $ born          <date> 1871-03-03, 1884-08-04, 1881-06-29, 1879-06-05, 1882...
    ## $ died          <date> 1957-02-19, 1941-03-18, 1939-04-24, 1907-01-25, 1917...
    ## $ full_name     <chr> NA, NA, NA, NA, "Lucien Georges Mazan", "Lucien Georg...
    ## $ nickname      <chr> "The Little Chimney-sweep", "Le rigolo (The joker)", ...
    ## $ birth_town    <chr> "Arvier", "Desvres", "Paris", "Moret-sur-Loing", "Ple...
    ## $ birth_country <chr> "Italy", "France", "France", "France", "France", "Fra...
    ## $ nationality   <chr> " France", " France", " France", " France", " France"...

``` r
skimr::skim(tdf_winners)
```

|                                                  |              |
| :----------------------------------------------- | :----------- |
| Name                                             | tdf\_winners |
| Number of rows                                   | 106          |
| Number of columns                                | 19           |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |              |
| Column type frequency:                           |              |
| character                                        | 7            |
| Date                                             | 3            |
| numeric                                          | 9            |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |              |
| Group variables                                  | None         |

Data summary

**Variable type: character**

| skim\_variable | n\_missing | complete\_rate | min | max | empty | n\_unique | whitespace |
| :------------- | ---------: | -------------: | --: | --: | ----: | --------: | ---------: |
| winner\_name   |          0 |           1.00 |  10 |  19 |     0 |        63 |          0 |
| winner\_team   |          0 |           1.00 |   3 |  33 |     0 |        48 |          0 |
| full\_name     |         60 |           0.43 |  15 |  33 |     0 |        23 |          0 |
| nickname       |         32 |           0.70 |   1 |  95 |     0 |        37 |          0 |
| birth\_town    |          0 |           1.00 |   3 |  28 |     0 |        58 |          0 |
| birth\_country |          0 |           1.00 |   3 |  11 |     0 |        15 |          0 |
| nationality    |          0 |           1.00 |   6 |  14 |     0 |        14 |        106 |

**Variable type: Date**

| skim\_variable | n\_missing | complete\_rate | min        | max        | median     | n\_unique |
| :------------- | ---------: | -------------: | :--------- | :--------- | :--------- | --------: |
| start\_date    |          0 |           1.00 | 1903-07-01 | 2019-07-06 | 1966-12-24 |       106 |
| born           |          0 |           1.00 | 1871-03-03 | 1997-01-13 | 1940-12-27 |        63 |
| died           |         50 |           0.53 | 1907-01-25 | 2019-08-16 | 1980-04-10 |        38 |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate |    mean |     sd |      p0 |     p25 |     p50 |     p75 |    p100 | hist  |
| :------------- | ---------: | -------------: | ------: | -----: | ------: | ------: | ------: | ------: | ------: | :---- |
| edition        |          0 |           1.00 |   53.50 |  30.74 |    1.00 |   27.25 |   53.50 |   79.75 |  106.00 | ▇▇▇▇▇ |
| distance       |          0 |           1.00 | 4212.06 | 704.28 | 2428.00 | 3657.88 | 4155.50 | 4652.50 | 5745.00 | ▁▇▇▆▃ |
| time\_overall  |          8 |           0.92 |  125.75 |  41.56 |   82.09 |   92.60 |  115.03 |  142.68 |  238.74 | ▇▅▂▁▂ |
| time\_margin   |          8 |           0.92 |    0.27 |   0.48 |    0.00 |    0.05 |    0.10 |    0.25 |    2.99 | ▇▁▁▁▁ |
| stage\_wins    |          0 |           1.00 |    2.74 |   1.84 |    0.00 |    1.00 |    2.00 |    4.00 |    8.00 | ▆▇▃▂▁ |
| stages\_led    |          0 |           1.00 |   10.79 |   5.31 |    1.00 |    6.25 |   12.00 |   14.00 |   22.00 | ▆▇▇▇▃ |
| height         |         40 |           0.62 |    1.78 |   0.06 |    1.61 |    1.74 |    1.77 |    1.82 |    1.90 | ▁▁▇▃▂ |
| weight         |         39 |           0.63 |   69.25 |   6.59 |   52.00 |   64.50 |   69.00 |   74.00 |   88.00 | ▁▆▇▇▁ |
| age            |          0 |           1.00 |   27.72 |   3.35 |   19.00 |   26.00 |   28.00 |   30.00 |   36.00 | ▁▃▇▃▂ |

Me quiero quedar solo con algunas variables. Voy a deshacerme de las que
tienen muchas NA o con las que no pienso trabajar: full\_name nickname
born birth\_town birth\_country died time\_margin stage\_wins
stages\_led

``` r
tdf_winners <- tdf_winners %>% 
        select(-full_name, 
               -nickname, 
               -born, 
               -birth_town,
               -birth_country, 
               -died, 
               -time_margin, 
               -stage_wins, 
               -stages_led)

tdf_winners
```

    ## # A tibble: 106 x 10
    ##    edition start_date winner_name winner_team distance time_overall height
    ##      <dbl> <date>     <chr>       <chr>          <dbl>        <dbl>  <dbl>
    ##  1       1 1903-07-01 Maurice Ga~ La Françai~     2428         94.6   1.62
    ##  2       2 1904-07-02 Henri Corn~ Conte           2428         96.1  NA   
    ##  3       3 1905-07-09 Louis Trou~ Peugeot–Wo~     2994         NA    NA   
    ##  4       4 1906-07-04 René Potti~ Peugeot–Wo~     4637         NA    NA   
    ##  5       5 1907-07-08 Lucien Pet~ Peugeot–Wo~     4488         NA    NA   
    ##  6       6 1908-07-13 Lucien Pet~ Peugeot–Wo~     4497         NA    NA   
    ##  7       7 1909-07-05 François F~ Alcyon–Dun~     4498         NA     1.78
    ##  8       8 1910-07-01 Octave Lap~ Alcyon–Dun~     4734         NA    NA   
    ##  9       9 1911-07-02 Gustave Ga~ Alcyon–Dun~     5343         NA    NA   
    ## 10      10 1912-06-30 Odile Defr~ Alcyon–Dun~     5289         NA    NA   
    ## # ... with 96 more rows, and 3 more variables: weight <dbl>, age <dbl>,
    ## #   nationality <chr>

Cual es la nacionalidad mas ganadora?

``` r
g0 <- tdf_winners %>% 
        group_by(nationality) %>% 
        summarise(n_win = n()) %>% 
        arrange(desc(n_win))
```

``` r
g0 %>% ggplot(aes(n_win, reorder(nationality, n_win))) +
        geom_bar(stat = "identity") +
        theme_minimal()
```

![](tour_de_france_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Los ciclistas mas ganadores?

``` r
tdf_winners %>% 
        group_by(winner_name) %>% 
        summarise(n_win = n()) %>% 
        arrange(desc(n_win))
```

    ## # A tibble: 63 x 2
    ##    winner_name      n_win
    ##    <chr>            <int>
    ##  1 Lance Armstrong      7
    ##  2 Bernard Hinault      5
    ##  3 Eddy Merckx          5
    ##  4 Jacques Anquetil     5
    ##  5 Miguel Induráin      5
    ##  6 Chris Froome         4
    ##  7 Greg LeMond          3
    ##  8 Louison Bobet        3
    ##  9 Philippe Thys        3
    ## 10 Alberto Contador     2
    ## # ... with 53 more rows

Y el equipo mas ganador?

``` r
tdf_winners %>% 
        group_by(winner_team) %>% 
        summarise(n_win = n()) %>% 
        arrange(desc(n_win))
```

    ## # A tibble: 48 x 2
    ##    winner_team         n_win
    ##    <chr>               <int>
    ##  1 France                 12
    ##  2 Alcyon–Dunlop           8
    ##  3 Peugeot–Wolber          7
    ##  4 Team Sky                6
    ##  5 U.S. Postal Service     6
    ##  6 Banesto                 5
    ##  7 Italy                   5
    ##  8 Automoto–Hutchinson     3
    ##  9 Belgium                 3
    ## 10 La Sportive             3
    ## # ... with 38 more rows

Como variaron las distancias a lo largo de las ediciones?

``` r
tdf_winners %>% 
        ggplot(aes(start_date, distance)) +
        geom_point(aes(color = nationality)) +
        geom_smooth(se = FALSE, color = "grey80", alpha = 0.5)
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](tour_de_france_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

Como varia la edad y el peso a lo largo de las ediciones?

``` r
tdf_winners %>% 
        ggplot(aes(age)) +
        geom_histogram(bins = 10)
```

![](tour_de_france_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

``` r
tdf_winners %>% 
        ggplot(aes(age)) +
        geom_density(fill = "grey70", alpha = 0.5, color = "grey70")
```

![](tour_de_france_files/figure-gfm/unnamed-chunk-11-1.png)<!-- --> Las
edades mas comunes de los ganadores son entre 25 y 31 aprox. Podria
destacar el ganador mas joven y el mas grande y en que anos.

``` r
## edad
tdf_winners %>% 
        ggplot(aes(start_date, age)) +
        geom_point()
```

![](tour_de_france_files/figure-gfm/unnamed-chunk-12-1.png)<!-- --> No
veo ninguna tendencia

``` r
tdf_winners %>% 
        ggplot(aes(weight)) +
        geom_density()
```

    ## Warning: Removed 39 rows containing non-finite values (stat_density).

![](tour_de_france_files/figure-gfm/unnamed-chunk-13-1.png)<!-- --> Los
pesos mas comunes entre los ganadores son entre 65 y 76 kg aprox. El mas
liviano en ganar y cuando? el mas pesado en ganar y cuando?

``` r
## peso
tdf_winners %>% 
        ggplot(aes(start_date, weight)) +
        geom_point() +
        geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 39 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 39 rows containing missing values (geom_point).

![](tour_de_france_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->
Tampoco, nada para sacar de aca.

``` r
tdf_winners %>% 
        ggplot(aes(height)) +
        geom_density()
```

    ## Warning: Removed 40 rows containing non-finite values (stat_density).

![](tour_de_france_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

La altura fue cambiando a lo largo de las ediciones. Podria hacer un
ridge geom?

``` r
tdf_winners %>% 
        ggplot(aes(start_date, height)) +
        geom_point() +
        geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 40 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 40 rows containing missing values (geom_point).

![](tour_de_france_files/figure-gfm/unnamed-chunk-16-1.png)<!-- --> No
es una tendencia muy clara, pero si podriamos decir que la altura minima
y maxima, en los ultimos anos, fue subiendo.

``` r
tdf_winners %>% 
        ggplot(aes(start_date, time_overall)) +
        geom_point()
```

    ## Warning: Removed 8 rows containing missing values (geom_point).

![](tour_de_france_files/figure-gfm/unnamed-chunk-17-1.png)<!-- --> Esto
si bajo mucho, era de esperarse. Pero habria que calcularlo como ratio
de la distancia…

``` r
tdf_winners <- tdf_winners %>% 
        mutate(time_per_km = time_overall/distance)

tdf_winners %>% 
        ggplot(aes(start_date, time_per_km)) +
        geom_point() +
        geom_smooth(se = FALSE, color = "grey70")
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 8 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 8 rows containing missing values (geom_point).

![](tour_de_france_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

Este es un interesante dato, aunque esperable. El tiempo por km bajo.
Podrian separarse en 3 etapas: de 1900 a 1960 aprox, donde disminuyo
estrepitosamente. De 1960 a 2000 que bajo pero a un ritmo menor. Y de
los 2000 a 2019 donde se mantuvo bastante estable (como que llego a un
plateau)

Habria que analizas mas en detalle los ultimos anos porque, a primera
vista: a pesar de que desde el 2000 las distancias totales disminuyeron,
los pesos promedio de los ganadores bajaron y las alturas promedio
subieron, no hubo una gran ganancia de tiempo por km.

Como calcularia la ganancia del tiempo promedio? Decada a decada? lustro
a lustro?

A priori, para hacer una visualizacion rapida para publicar, seria esta
ultima. Pero luego haria zoom en la ultima decada para comparar: aumento
promedio de altura, disminucion promedio de peso, disminucion de
distancia total, pero sin una correlacion con la ganancia en los
tiempos…

Otras preguntas:

Relacion entre peso y tiempo por km? Relacion entre altura y tiempo por
km?

``` r
tdf_winners %>% 
        ggplot(aes(weight, time_per_km)) +
        geom_point() +
        geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 40 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 40 rows containing missing values (geom_point).

![](tour_de_france_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

``` r
tdf_winners %>% 
        ggplot(aes(height, time_per_km)) +
        geom_point() +
        geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 41 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 41 rows containing missing values (geom_point).

![](tour_de_france_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

OK. Cual es la historia?

### 3\. Visaulizacion final: the story

Comencé a hacer EDA según las recomendaciones de Hadley Wickham (R4DS).
Primero, analizando cómo varían las variables y, luego, cómo varían los
datos entre variables. Por lo menos los features en los que, a primera
instancia, me parecieron más interesantes.
