
### <https://github.com/hauselin/Rcode>

#### Source or load `summaryh()` function

``` r
source("https://raw.githubusercontent.com/hauselin/Rcode/master/summaryh.R")
```

    ## r: .10 (small), .30 (medium), .50 (large) (Cohen, 1992)
    ## d: 0.20 (small), 0.50 (medium), .80 (large) (Cohen, 1992)
    ## R2: .02 (small), .13 (medium), .26 (large) (Cohen, 1992)

#### Linear regression standard R output

``` r
model <- lm(mpg ~ drat, mtcars)
summary(model)
```

    ## 
    ## Call:
    ## lm(formula = mpg ~ drat, data = mtcars)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -9.0775 -2.6803 -0.2095  2.2976  9.0225 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   -7.525      5.477  -1.374     0.18    
    ## drat           7.678      1.507   5.096 1.78e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 4.485 on 30 degrees of freedom
    ## Multiple R-squared:  0.464,  Adjusted R-squared:  0.4461 
    ## F-statistic: 25.97 on 1 and 30 DF,  p-value: 1.776e-05

#### Linear regression `summaryh()` output

``` r
summaryh(model)
```

    ##           term                                                 results
    ## 1: (Intercept) b = −7.52, SE = 5.48, t(30) = −1.37, p = .180, r = 0.24
    ## 2:        drat   b = 7.68, SE = 1.51, t(30) = 5.10, p < .001, r = 0.68

#### Linear regression `summaryh()` output: changing default output

``` r
summaryh(model, decimal = 1)
```

    ##           term                                             results
    ## 1: (Intercept) b = −7.5, SE = 5.5, t(30) = −1.4, p = .180, r = 0.2
    ## 2:        drat   b = 7.7, SE = 1.5, t(30) = 5.1, p < .001, r = 0.7

#### Linear regression `summaryh()` output: changing default output

``` r
summaryh(model, showTable = T)
```

    ## $results
    ##           term                                                 results
    ## 1: (Intercept) b = −7.52, SE = 5.48, t(30) = −1.37, p = .180, r = 0.24
    ## 2:        drat   b = 7.68, SE = 1.51, t(30) = 5.10, p < .001, r = 0.68
    ## 
    ## $results2
    ##           term estimate std.error df statistic p.value  es.r   es.d
    ## 1: (Intercept)   -7.525     5.477 30    -1.374    0.18 0.243 -0.502
    ## 2:        drat    7.678     1.507 30     5.096    0.00 0.681  1.861
    ##    es.r.squared es.adj.r.squared
    ## 1:        0.464            0.446
    ## 2:        0.464            0.446

#### Linear regression `summaryh()` output: show other effect sizes

``` r
summaryh(model, showEffectSizesTable = T)
```

    ## $results
    ##           term                                                 results
    ## 1: (Intercept) b = −7.52, SE = 5.48, t(30) = −1.37, p = .180, r = 0.24
    ## 2:        drat   b = 7.68, SE = 1.51, t(30) = 5.10, p < .001, r = 0.68
    ## 
    ## $effectSizes
    ##           term    d    r   R2    f oddsratio logoddsratio  auc
    ## 1: (Intercept) 0.50 0.24 0.06 0.25      2.48         0.91 0.69
    ## 2:        drat 1.86 0.68 0.46 0.93     29.18         3.37 0.97

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
summaryh(aov(mpg ~ gear, mtcars), decimal = 1)
```

    ##    term                           results
    ## 1: gear F(1, 30) = 9.0, p = .005, r = 0.5

#### Multi-level/mixed effects model with lme4 and lmerTest

``` r
library(lme4); library(lmerTest) # load packages to fit mixed effects models
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
