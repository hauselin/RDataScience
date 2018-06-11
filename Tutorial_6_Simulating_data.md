Tutorial 6: Simulating data
================
Hause Lin

-   [Loading frequently-used packages with `library()`](#loading-frequently-used-packages-with-library)
-   [Generate random values from a normal distribution](#generate-random-values-from-a-normal-distribution)
-   [Generate random values from a uniform distribution](#generate-random-values-from-a-uniform-distribution)
-   [Simulate a t-test with `rnorm()`](#simulate-a-t-test-with-rnorm)
-   [Manipulating strings](#manipulating-strings)
    -   [Manipulating string resources](#manipulating-string-resources)
-   [the apply family in R (looping without for loops)](#the-apply-family-in-r-looping-without-for-loops)

Loading frequently-used packages with `library()`
-------------------------------------------------

I always load my frequently-used packages at the top of each script.

``` r
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
```

Generate random values from a normal distribution
-------------------------------------------------

``` r
rnorm(n = 10) # 10 values (values from standard normal distribution: mean 0, sd 1)
```

    ##  [1]  1.58188155 -0.35536269 -0.11305349 -0.06464051 -0.75514289
    ##  [6] -1.10487855  0.98521874  0.63832900  0.86510889  0.76785454

``` r
rnorm(n = 100, mean = 100, sd = 15) # 100 values from a normal distribution (mean 100, sd = 15)
```

    ##   [1]  78.04936  99.50138  59.63304 100.85478  96.90804  76.94553  95.63313
    ##   [8]  77.36157 114.44721  92.51570 114.04754 129.13923  98.71398 105.42377
    ##  [15] 108.14881  87.43734  99.08550  94.35206  89.53104 105.19141  89.93340
    ##  [22] 112.20107  85.89531 122.54001  74.53852 106.03746 107.86406 111.21071
    ##  [29]  94.89827  95.26554 116.70382 125.31597 103.40073 122.14597  95.72300
    ##  [36] 100.34938  87.19389  82.68160 106.82811  95.72578  95.36466 108.53076
    ##  [43] 110.49463  80.75613 115.32315 111.14432  89.65943 103.53056 122.73448
    ##  [50]  88.77138  83.03387  84.00035 112.27671 106.37090  91.73340  86.51162
    ##  [57]  90.07962  89.27224  88.62896 113.90552  71.33942 105.41166  90.26834
    ##  [64]  74.84516  92.92816  87.07334 116.16360  91.07856 100.70607  84.96223
    ##  [71]  99.67103 104.57183  90.19126  93.76207  69.23009 101.05848 121.09933
    ##  [78] 118.29944  96.76962 123.84823 114.16311 104.94704 110.01658 119.71836
    ##  [85]  93.97957  94.44575 101.48519  75.03665  94.97480 101.72513 111.25695
    ##  [92]  83.06452  72.25641 112.44824 100.11460  94.50237 112.16784 115.65530
    ##  [99] 121.40332  82.38720

``` r
x <- rnorm(n = 1000, mean = 100, sd = 15) # 1000 values from a normal distribution (mean 100, sd = 15)
hist(x) # base R plot histogram
```

![](Tutorial_6_Simulating_data_files/figure-markdown_github/unnamed-chunk-3-1.png)

Generate random values from a uniform distribution
--------------------------------------------------

``` r
x <- runif(n = 1000, min = 10, max = 20)
hist(x)
```

![](Tutorial_6_Simulating_data_files/figure-markdown_github/unnamed-chunk-4-1.png)

Simulate a t-test with `rnorm()`
--------------------------------

Group a (n = 20): mean 100, sd 15 Group b (n = 20): mean 115, sd 20

``` r
fakeData <- data_frame(group = rep(c("a", "b"), each = 20), 
                       value = c(rnorm(20, 100, 15), rnorm(20, 115, 20))) 
print(fakeData, n = Inf)
```

    ## # A tibble: 40 x 2
    ##    group value
    ##    <chr> <dbl>
    ##  1 a      67.4
    ##  2 a     103. 
    ##  3 a      86.3
    ##  4 a     119. 
    ##  5 a      94.7
    ##  6 a     107. 
    ##  7 a     111. 
    ##  8 a     105. 
    ##  9 a      90.2
    ## 10 a     126. 
    ## 11 a     100. 
    ## 12 a     110. 
    ## 13 a     113. 
    ## 14 a      92.0
    ## 15 a     101. 
    ## 16 a     110. 
    ## 17 a     106. 
    ## 18 a     132. 
    ## 19 a     112. 
    ## 20 a     107. 
    ## 21 b     108. 
    ## 22 b     155. 
    ## 23 b     127. 
    ## 24 b     133. 
    ## 25 b     114. 
    ## 26 b     131. 
    ## 27 b     122. 
    ## 28 b     114. 
    ## 29 b      81.7
    ## 30 b     126. 
    ## 31 b     137. 
    ## 32 b     135. 
    ## 33 b     142. 
    ## 34 b      96.4
    ## 35 b      88.6
    ## 36 b      95.0
    ## 37 b     122. 
    ## 38 b      88.4
    ## 39 b      79.5
    ## 40 b     132.

Will group differences be significant?

``` r
simulateResults <- t.test(value ~ group, data = fakeData)
simulateResults
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  value by group
    ## t = -2.011, df = 32.857, p-value = 0.05259
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -23.561386   0.139182
    ## sample estimates:
    ## mean in group a mean in group b 
    ##        104.6895        116.4006

``` r
source("https://raw.githubusercontent.com/hauselin/Rcode/master/summaryh.R")
```

    ## 
    ## Attaching package: 'sjstats'

    ## The following object is masked from 'package:broom':
    ## 
    ##     bootstrap

    ## r: .10 (small), .30 (medium), .50 (large) (Cohen, 1992)
    ## d: 0.20 (small), 0.50 (medium), .80 (large) (Cohen, 1992)
    ## R2: .02 (small), .13 (medium), .26 (large) (Cohen, 1992)

``` r
summaryh(simulateResults) # my custom function
```

    ##                              results
    ## 1: t(33) = −2.01, p = .053, r = 0.33

Manipulating strings
--------------------

Substitute patterns

``` r
gsub(pattern = "a", replacement = "_HEY_", x = c("aba", "cae", "xxx"))
```

    ## [1] "_HEY_b_HEY_" "c_HEY_e"     "xxx"

``` r
gsub(pattern = "a", replacement = " ", x = c("aba", "cae", "xxx"))
```

    ## [1] " b " "c e" "xxx"

``` r
gsub(pattern = "a", replacement = "", x = c("aba", "cae", "xxx"))
```

    ## [1] "b"   "ce"  "xxx"

Find matching patterns

``` r
text <- c("foot","lefroo", "bafOobar", "zeb")
grep(pattern = "oo", x = text, ignore.case = T)
```

    ## [1] 1 2 3

``` r
grep(pattern = "oo", x = text, ignore.case = F)
```

    ## [1] 1 2

``` r
grepl(pattern = "oo", x = text, ignore.case = T)
```

    ## [1]  TRUE  TRUE  TRUE FALSE

``` r
grepl(pattern = "oo", x = text, ignore.case = F)
```

    ## [1]  TRUE  TRUE FALSE FALSE

### Manipulating string resources

-   (stringr tutorial/vignette)\[<https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html>\]

the apply family in R (looping without for loops)
-------------------------------------------------

-   `lapply`, `apply`, `sapply`, `vapply`, `tapply`
