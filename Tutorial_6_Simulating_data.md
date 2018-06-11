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

    ##  [1] -0.3735620  0.7777959  0.7445974  1.1672451 -1.2064221  0.6568749
    ##  [7] -1.1431620 -1.2937284  0.1561832 -0.6357654

``` r
rnorm(n = 100, mean = 100, sd = 15) # 100 values from a normal distribution (mean 100, sd = 15)
```

    ##   [1] 105.74860 113.92204  81.87528  90.17662  92.67157  96.93190  92.00505
    ##   [8] 101.04087  97.23212  97.80605  89.23337 122.72160 106.51697  87.19012
    ##  [15] 107.78176 105.24514  89.56983  99.78315 110.77149  88.08127  87.45945
    ##  [22]  96.47797 113.15628 103.25982  85.37927  84.38860  84.51486 114.34191
    ##  [29] 101.18028  98.42746 103.58979 111.90029 116.32861 101.12761  89.11802
    ##  [36] 132.85740 120.16863  83.95442 123.76461 105.44488  95.08182 121.44770
    ##  [43] 105.84660 112.51493  94.42049 102.69747  83.07766  92.65615  93.74298
    ##  [50]  89.08314 120.39745  70.12123 112.82606  95.68735 103.12653  92.15702
    ##  [57]  91.45644  66.55942  98.15931 130.62506  64.06313 105.96313 121.74977
    ##  [64]  85.88973 111.67411 105.92233 112.88494  73.68201  86.32469  95.56725
    ##  [71] 124.13204  85.74518  98.95612 110.78744 114.01290 104.17870  83.95371
    ##  [78]  95.25683 115.55937  98.44797  97.78144 104.63717 103.66741 105.21529
    ##  [85] 104.99607  94.87820  88.28022  87.53715 115.16225 107.77011 110.25043
    ##  [92]  84.74748 110.05289 104.09761 119.55804  82.18753 121.26358 124.12697
    ##  [99] 120.73847 100.84527

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
    ##  1 a     107. 
    ##  2 a     140. 
    ##  3 a     101. 
    ##  4 a     105. 
    ##  5 a     118. 
    ##  6 a      85.6
    ##  7 a      92.5
    ##  8 a      65.2
    ##  9 a      83.7
    ## 10 a     103. 
    ## 11 a      66.4
    ## 12 a      91.6
    ## 13 a      86.6
    ## 14 a      90.6
    ## 15 a     111. 
    ## 16 a      84.5
    ## 17 a     101. 
    ## 18 a      87.8
    ## 19 a     119. 
    ## 20 a      97.8
    ## 21 b     125. 
    ## 22 b      96.2
    ## 23 b     112. 
    ## 24 b     128. 
    ## 25 b     125. 
    ## 26 b     147. 
    ## 27 b      77.2
    ## 28 b     141. 
    ## 29 b     149. 
    ## 30 b     108. 
    ## 31 b     127. 
    ## 32 b     102. 
    ## 33 b      83.8
    ## 34 b     118. 
    ## 35 b     118. 
    ## 36 b     127. 
    ## 37 b      99.6
    ## 38 b      95.9
    ## 39 b     113. 
    ## 40 b     120.

Will group differences be significant?

``` r
simulateResults <- t.test(value ~ group, data = fakeData)
simulateResults
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  value by group
    ## t = -3.2132, df = 37.663, p-value = 0.00269
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -30.599807  -6.941229
    ## sample estimates:
    ## mean in group a mean in group b 
    ##        96.85751       115.62803

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
    ## 1: t(38) = −3.21, p = .003, r = 0.46

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

-   [stringr tutorial/vignette](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html)
-   [stringr github site](https://github.com/tidyverse/stringr)

the apply family in R (looping without for loops)
-------------------------------------------------

-   `lapply`, `apply`, `sapply`, `vapply`, `tapply`
