
### <https://github.com/hauselin/Rcode>

``` r
source("https://raw.githubusercontent.com/hauselin/Rcode/master/summaryh.R")
```

    ## ── Attaching packages ───────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.5
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.5
    ## ✔ tidyr   0.8.1     ✔ stringr 1.3.1
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ── Conflicts ──────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    ## 
    ## Attaching package: 'data.table'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     between, first, last

    ## The following object is masked from 'package:purrr':
    ## 
    ##     transpose

    ## r: .10 (small), .30 (medium), .50 (large) (Cohen, 1992)
    ## d: 0.20 (small), 0.50 (medium), .80 (large) (Cohen, 1992)
    ## R2: .02 (small), .13 (medium), .26 (large) (Cohen, 1992)

#### Linear regression standard R output

``` r
model <- lm(mpg ~ cyl, mtcars)
summary(model)
```

    ## 
    ## Call:
    ## lm(formula = mpg ~ cyl, data = mtcars)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -4.9814 -2.1185  0.2217  1.0717  7.5186 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  37.8846     2.0738   18.27  < 2e-16 ***
    ## cyl          -2.8758     0.3224   -8.92 6.11e-10 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 3.206 on 30 degrees of freedom
    ## Multiple R-squared:  0.7262, Adjusted R-squared:  0.7171 
    ## F-statistic: 79.56 on 1 and 30 DF,  p-value: 6.113e-10

#### Linear regression `summaryh()` output

``` r
summaryh(model)
```

    ##           term                                                 results
    ## 1: (Intercept) b = 37.88, SE = 2.07, t(30) = 18.27, p < .001, r = 0.96
    ## 2:         cyl b = −2.88, SE = 0.32, t(30) = −8.92, p < .001, r = 0.85

#### Linear regression `summaryh()` output: changing default output (5 decimals)

``` r
summaryh(model, decimal = 5)
```

    ##           term
    ## 1: (Intercept)
    ## 2:         cyl
    ##                                                                results
    ## 1: b = 37.88458, SE = 2.07384, t(30) = 18.26781, p < .001, r = 0.95787
    ## 2: b = −2.87579, SE = 0.32241, t(30) = −8.91970, p < .001, r = 0.85216

#### Linear regression `summaryh()` output: changing output

``` r
summaryh(model, showTable = T)
```

    ## $results
    ##           term                                                 results
    ## 1: (Intercept) b = 37.88, SE = 2.07, t(30) = 18.27, p < .001, r = 0.96
    ## 2:         cyl b = −2.88, SE = 0.32, t(30) = −8.92, p < .001, r = 0.85
    ## 
    ## $results2
    ##           term estimate std.error df statistic p.value  es.r   es.d
    ## 1: (Intercept)   37.885     2.074 30    18.268       0 0.958  6.670
    ## 2:         cyl   -2.876     0.322 30    -8.920       0 0.852 -3.257
    ##    es.r.squared es.adj.r.squared
    ## 1:        0.726            0.717
    ## 2:        0.726            0.717

#### Linear regression `summaryh()` output: show other effect sizes

``` r
summaryh(model, showEffectSizesTable = T)
```

    ## $results
    ##           term                                                 results
    ## 1: (Intercept) b = 37.88, SE = 2.07, t(30) = 18.27, p < .001, r = 0.96
    ## 2:         cyl b = −2.88, SE = 0.32, t(30) = −8.92, p < .001, r = 0.85
    ## 
    ## $effectSizes
    ##           term    d    r   R2    f oddsratio logoddsratio auc
    ## 1: (Intercept) 6.68 0.96 0.92 3.34 183255.49        12.12   1
    ## 2:         cyl 3.25 0.85 0.73 1.63    366.31         5.90   1

#### Correlation

``` r
summaryh(cor.test(mtcars$mpg, mtcars$cyl))
```

    ##                    results
    ## 1: r(30) = −0.85, p < .001

#### t-test

``` r
summaryh(t.test(mpg ~ vs, mtcars))
```

    ##                              results
    ## 1: t(23) = −4.67, p < .001, r = 0.70

#### ANOVA

``` r
summaryh(aov(mpg ~ gear, mtcars), decimal = 5)
```

    ##    term                                     results
    ## 1: gear F(1, 30) = 8.99514, p = .00540, r = 0.48028

#### Multi-level/mixed effects model with lme4 and lmerTest

``` r
library(lme4); library(lmerTest) # load packages to fit mixed effects models
```

    ## Loading required package: Matrix

    ## 
    ## Attaching package: 'Matrix'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     expand

    ## 
    ## Attaching package: 'lmerTest'

    ## The following object is masked from 'package:lme4':
    ## 
    ##     lmer

    ## The following object is masked from 'package:stats':
    ## 
    ##     step

``` r
model <- lmer(weight ~ Time * Diet  + (1 + Time | Chick), data = ChickWeight)
summaryh(model)
```

    ##           term                                                  results
    ## 1: (Intercept)  b = 33.66, SE = 2.92, t(48) = 11.53, p < .001, r = 0.86
    ## 2:        Time    b = 6.28, SE = 0.76, t(47) = 8.24, p < .001, r = 0.77
    ## 3:       Diet2  b = −5.03, SE = 5.01, t(46) = −1.00, p = .321, r = 0.15
    ## 4:       Diet3 b = −15.41, SE = 5.01, t(46) = −3.08, p = .004, r = 0.41
    ## 5:       Diet4  b = −1.75, SE = 5.02, t(46) = −0.35, p = .729, r = 0.05
    ## 6:  Time:Diet2    b = 2.33, SE = 1.30, t(46) = 1.79, p = .080, r = 0.26
    ## 7:  Time:Diet3    b = 5.15, SE = 1.30, t(46) = 3.95, p < .001, r = 0.50
    ## 8:  Time:Diet4    b = 3.25, SE = 1.31, t(46) = 2.49, p = .016, r = 0.35

### <https://github.com/hauselin/Rcode>

### <https://github.com/hauselin/RDataScience>
