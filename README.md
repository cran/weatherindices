
<!-- README.md is generated from README.Rmd. Please edit that file -->

# weatherindices

<!-- badges: start -->

[![R-CMD-check](https://github.com/akstat21/weatherindices/workflows/R-CMD-check/badge.svg)](https://github.com/akstat21/weatherindices/actions)
<!-- badges: end -->

The goal of weatherindices is to facilitate the calculation of Weather
Indices for crop yield modeling.

## Installation

You can install the development version of weatherindices from
[GitHub](https://github.com/akstat21/weatherindices)

``` r
# install.packages("devtools")
devtools::install_github("akstat21/weatherindices")
```

## Example

To calculate weather indices you require weekly weather data and yearly
yield data. Both the data should be separate variables. The number of
data points in weather variable should be multiple of numbers of years
of yield data and number of weeks considered in each year.

``` r
library(weatherindices)
data(Burdwanweather) #Weekly weather data for the rice growing season in Burdwan
data(Burdwanriceyield) #Yearly Yield data of rice  in Burdwan
wwi.maxtem<-wwi(Burdwanriceyield$burdwan,Burdwanweather$Max.Temperature)
wwi.maxtem
```

    ##  [1] 33.14249 32.51634 35.96486 31.53676 34.88116 35.34955 33.88576 33.68535
    ##  [9] 34.35228 33.81517 33.76889 34.35719 33.42879 32.97895 33.25367 33.55808
    ## [17] 33.69856 34.04214 32.90105 30.63825 31.80091 32.37349 34.51790 32.84096
    ## [25] 35.32921 31.43451 32.36830 31.46721 34.06736 33.93954 32.20486 34.58240
    ## [33] 31.96571 33.42984 32.72208 33.19853 32.53645 32.91940 35.10816
