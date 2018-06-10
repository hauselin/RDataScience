Tutorial with real Stroop data
================
Hause Lin

``` r
rm(list = ls()) # clear workspace and environment
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
# load("Tutorial with real Stroop data.RData")
# save.image("Tutorial with real Stroop data.RData")

source("https://raw.githubusercontent.com/hauselin/Rcode/master/summaryh.R")
source("https://raw.githubusercontent.com/hauselin/Rcode/master/detectOutliers.R")
source("https://raw.githubusercontent.com/hauselin/Rcode/master/se.R")
```

``` r
subjectData <- file.path(getwd(), 'Data') # data path
dataDir <- list.files(subjectData, full.names = T) # full path to all files/directories in raw data folder
filesToRead <- dataDir[grep(pattern = 'StroopRawSubject', x = dataDir)] # paths to all the matching files
dataRaw <- lapply(1:length(filesToRead), function(x) fread(filesToRead[x])) # read all matching files in and store in a list
dataRaw <- tbl_dt(rbindlist(dataRaw)) # convert that list to a datatable
data <- copy(dataRaw) # make a copy of the data
```

``` r
data
```

    ## Source: local data table [1,800 x 20]
    ## 
    ## # A tibble: 1,800 x 20
    ##      pNo condition congruency  wordShown correctResp trialnum resp     acc
    ##    <int> <chr>     <chr>       <chr>     <chr>          <int> <chr>  <int>
    ##  1     5 control   incongruent yellow    blue               1 yellow     0
    ##  2     5 control   congruent   blue      blue               2 blue       1
    ##  3     5 control   congruent   blue      blue               3 blue       1
    ##  4     5 control   congruent   yellow    yellow             4 yellow     1
    ##  5     5 control   congruent   yellow    yellow             5 yellow     1
    ##  6     5 control   incongruent blue      red                6 red        1
    ##  7     5 control   congruent   red       red                7 red        1
    ##  8     5 control   incongruent blue      yellow             8 blue       0
    ##  9     5 control   congruent   red       red                9 red        1
    ## 10     5 control   congruent   red       red               10 red        1
    ## # ... with 1,790 more rows, and 12 more variables: rt <int>,
    ## #   include <int>, mentaldemand <dbl>, effort <dbl>, frustration <dbl>,
    ## #   bored <dbl>, fatigue <dbl>, acs <dbl>, implicitWillpower <dbl>,
    ## #   bigFiveCon <dbl>, bsc <dbl>, srsq <dbl>

``` r
glimpse(data)
```

    ## Observations: 1,800
    ## Variables: 20
    ## $ pNo               <int> 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,...
    ## $ condition         <chr> "control", "control", "control", "control", ...
    ## $ congruency        <chr> "incongruent", "congruent", "congruent", "co...
    ## $ wordShown         <chr> "yellow", "blue", "blue", "yellow", "yellow"...
    ## $ correctResp       <chr> "blue", "blue", "blue", "yellow", "yellow", ...
    ## $ trialnum          <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1...
    ## $ resp              <chr> "yellow", "blue", "blue", "yellow", "yellow"...
    ## $ acc               <int> 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1,...
    ## $ rt                <int> 732, 922, 1594, 670, 811, 1573, 774, 1061, 1...
    ## $ include           <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
    ## $ mentaldemand      <dbl> 3.4, 3.4, 3.4, 3.4, 3.4, 3.4, 3.4, 3.4, 3.4,...
    ## $ effort            <dbl> 2.9, 2.9, 2.9, 2.9, 2.9, 2.9, 2.9, 2.9, 2.9,...
    ## $ frustration       <dbl> 1.9, 1.9, 1.9, 1.9, 1.9, 1.9, 1.9, 1.9, 1.9,...
    ## $ bored             <dbl> 2.6, 2.6, 2.6, 2.6, 2.6, 2.6, 2.6, 2.6, 2.6,...
    ## $ fatigue           <dbl> 3.1, 3.1, 3.1, 3.1, 3.1, 3.1, 3.1, 3.1, 3.1,...
    ## $ acs               <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    ## $ implicitWillpower <dbl> 2.166667, 2.166667, 2.166667, 2.166667, 2.16...
    ## $ bigFiveCon        <dbl> 2.777778, 2.777778, 2.777778, 2.777778, 2.77...
    ## $ bsc               <dbl> 2.230769, 2.230769, 2.230769, 2.230769, 2.23...
    ## $ srsq              <dbl> 2.9, 2.9, 2.9, 2.9, 2.9, 2.9, 2.9, 2.9, 2.9,...

``` r
data[, n_distinct(pNo)] # number of subjects
```

    ## [1] 5

``` r
data[, .N, by = pNo] # trials per subject
```

    ## Source: local data table [5 x 2]
    ## 
    ## # A tibble: 5 x 2
    ##     pNo     N
    ##   <int> <int>
    ## 1     5   360
    ## 2    11   360
    ## 3    13   360
    ## 4    14   360
    ## 5    16   360

``` r
data[, unique(condition)]
```

    ## [1] "control" "test"

``` r
data[, rt := rt / 1000]
```

``` r
data[, rtMAD := outliersMAD(rt, MADCutOff = 3), by = pNo] # convert extreme rt values to NA
```

    ## 29 outliers detected.

    ## Outliers replaced with NA

    ## 11 outliers detected.

    ## Outliers replaced with NA

    ## 19 outliers detected.

    ## Outliers replaced with NA

    ## 25 outliers detected.

    ## Outliers replaced with NA

    ## 17 outliers detected.

    ## Outliers replaced with NA

``` r
summary(data)
```

    ##       pNo        condition          congruency         wordShown        
    ##  Min.   : 5.0   Length:1800        Length:1800        Length:1800       
    ##  1st Qu.:11.0   Class :character   Class :character   Class :character  
    ##  Median :13.0   Mode  :character   Mode  :character   Mode  :character  
    ##  Mean   :11.8                                                           
    ##  3rd Qu.:14.0                                                           
    ##  Max.   :16.0                                                           
    ##                                                                         
    ##  correctResp           trialnum          resp                acc       
    ##  Length:1800        Min.   :  1.00   Length:1800        Min.   :0.000  
    ##  Class :character   1st Qu.: 45.75   Class :character   1st Qu.:1.000  
    ##  Mode  :character   Median : 90.50   Mode  :character   Median :1.000  
    ##                     Mean   : 90.50                      Mean   :0.935  
    ##                     3rd Qu.:135.25                      3rd Qu.:1.000  
    ##                     Max.   :180.00                      Max.   :1.000  
    ##                                                                        
    ##        rt             include   mentaldemand      effort    
    ##  Min.   : 0.0130   Min.   :1   Min.   :1.00   Min.   :1.00  
    ##  1st Qu.: 0.5890   1st Qu.:1   1st Qu.:2.00   1st Qu.:1.60  
    ##  Median : 0.7210   Median :1   Median :3.80   Median :2.90  
    ##  Mean   : 0.8523   Mean   :1   Mean   :3.64   Mean   :3.32  
    ##  3rd Qu.: 0.9533   3rd Qu.:1   3rd Qu.:4.40   3rd Qu.:5.20  
    ##  Max.   :10.9890   Max.   :1   Max.   :7.00   Max.   :6.40  
    ##                                                             
    ##   frustration       bored         fatigue           acs        
    ##  Min.   :1.00   Min.   :2.60   Min.   :1.000   Min.   :0.0000  
    ##  1st Qu.:1.50   1st Qu.:3.50   1st Qu.:1.325   1st Qu.:0.2500  
    ##  Median :3.50   Median :3.90   Median :3.050   Median :0.3333  
    ##  Mean   :3.47   Mean   :4.83   Mean   :3.150   Mean   :0.3000  
    ##  3rd Qu.:4.40   3rd Qu.:7.00   3rd Qu.:4.300   3rd Qu.:0.3333  
    ##  Max.   :7.00   Max.   :7.00   Max.   :7.000   Max.   :0.5833  
    ##                                NA's   :360                     
    ##  implicitWillpower   bigFiveCon         bsc             srsq     
    ##  Min.   :1.667     Min.   :2.111   Min.   :1.462   Min.   :2.40  
    ##  1st Qu.:2.000     1st Qu.:2.556   1st Qu.:2.231   1st Qu.:2.90  
    ##  Median :2.167     Median :2.778   Median :2.538   Median :3.40  
    ##  Mean   :2.567     Mean   :3.111   Mean   :2.723   Mean   :3.12  
    ##  3rd Qu.:3.333     3rd Qu.:3.889   3rd Qu.:2.923   3rd Qu.:3.40  
    ##  Max.   :3.667     Max.   :4.222   Max.   :4.462   Max.   :3.50  
    ##                                                                  
    ##      rtMAD       
    ##  Min.   :0.0100  
    ##  1st Qu.:0.5800  
    ##  Median :0.7100  
    ##  Mean   :0.7585  
    ##  3rd Qu.:0.9000  
    ##  Max.   :1.7500  
    ##  NA's   :101

``` r
data[is.na(rtMAD), acc := NA]
summary(data)
```

    ##       pNo        condition          congruency         wordShown        
    ##  Min.   : 5.0   Length:1800        Length:1800        Length:1800       
    ##  1st Qu.:11.0   Class :character   Class :character   Class :character  
    ##  Median :13.0   Mode  :character   Mode  :character   Mode  :character  
    ##  Mean   :11.8                                                           
    ##  3rd Qu.:14.0                                                           
    ##  Max.   :16.0                                                           
    ##                                                                         
    ##  correctResp           trialnum          resp                acc        
    ##  Length:1800        Min.   :  1.00   Length:1800        Min.   :0.0000  
    ##  Class :character   1st Qu.: 45.75   Class :character   1st Qu.:1.0000  
    ##  Mode  :character   Median : 90.50   Mode  :character   Median :1.0000  
    ##                     Mean   : 90.50                      Mean   :0.9364  
    ##                     3rd Qu.:135.25                      3rd Qu.:1.0000  
    ##                     Max.   :180.00                      Max.   :1.0000  
    ##                                                         NA's   :101     
    ##        rt             include   mentaldemand      effort    
    ##  Min.   : 0.0130   Min.   :1   Min.   :1.00   Min.   :1.00  
    ##  1st Qu.: 0.5890   1st Qu.:1   1st Qu.:2.00   1st Qu.:1.60  
    ##  Median : 0.7210   Median :1   Median :3.80   Median :2.90  
    ##  Mean   : 0.8523   Mean   :1   Mean   :3.64   Mean   :3.32  
    ##  3rd Qu.: 0.9533   3rd Qu.:1   3rd Qu.:4.40   3rd Qu.:5.20  
    ##  Max.   :10.9890   Max.   :1   Max.   :7.00   Max.   :6.40  
    ##                                                             
    ##   frustration       bored         fatigue           acs        
    ##  Min.   :1.00   Min.   :2.60   Min.   :1.000   Min.   :0.0000  
    ##  1st Qu.:1.50   1st Qu.:3.50   1st Qu.:1.325   1st Qu.:0.2500  
    ##  Median :3.50   Median :3.90   Median :3.050   Median :0.3333  
    ##  Mean   :3.47   Mean   :4.83   Mean   :3.150   Mean   :0.3000  
    ##  3rd Qu.:4.40   3rd Qu.:7.00   3rd Qu.:4.300   3rd Qu.:0.3333  
    ##  Max.   :7.00   Max.   :7.00   Max.   :7.000   Max.   :0.5833  
    ##                                NA's   :360                     
    ##  implicitWillpower   bigFiveCon         bsc             srsq     
    ##  Min.   :1.667     Min.   :2.111   Min.   :1.462   Min.   :2.40  
    ##  1st Qu.:2.000     1st Qu.:2.556   1st Qu.:2.231   1st Qu.:2.90  
    ##  Median :2.167     Median :2.778   Median :2.538   Median :3.40  
    ##  Mean   :2.567     Mean   :3.111   Mean   :2.723   Mean   :3.12  
    ##  3rd Qu.:3.333     3rd Qu.:3.889   3rd Qu.:2.923   3rd Qu.:3.40  
    ##  Max.   :3.667     Max.   :4.222   Max.   :4.462   Max.   :3.50  
    ##                                                                  
    ##      rtMAD       
    ##  Min.   :0.0100  
    ##  1st Qu.:0.5800  
    ##  Median :0.7100  
    ##  Mean   :0.7585  
    ##  3rd Qu.:0.9000  
    ##  Max.   :1.7500  
    ##  NA's   :101

``` r
grandAvg_conditionCongruency <- seWithin(data = data, measurevar = c("acc", "rt"), withinvars = c("condition", "congruency"), idvar = 'pNo')
```

    ## Automatically converting the following non-factors to factors: condition, congruency

    ## Joining, by = "pNo"

    ## Joining, by = c("condition", "congruency", "N")

    ## Factors have been converted to characters.

    ## Confidence intervals: 0.95

    ## 

    ## Joining, by = "pNo"

    ## Joining, by = c("condition", "congruency", "N")

    ## Factors have been converted to characters.

    ## Confidence intervals: 0.95

    ## 

    ## $acc
    ##    condition  congruency   N       acc        sd          se         ci
    ## 1:   control   congruent 581 0.9862306 0.1423022 0.005903689 0.01159521
    ## 2:   control incongruent 267 0.9138577 0.3215533 0.019678745 0.03874592
    ## 3:      test   congruent 575 0.9530435 0.2393654 0.009982227 0.01960615
    ## 4:      test incongruent 276 0.8188406 0.4374868 0.026333613 0.05184108
    ## 
    ## $rt
    ##    condition  congruency   N        rt        sd         se         ci
    ## 1:   control   congruent 600 0.7826800 0.4140163 0.01690214 0.03319467
    ## 2:   control incongruent 300 1.0893800 1.2134340 0.07005764 0.13786852
    ## 3:      test   congruent 600 0.7713283 0.7035774 0.02872343 0.05641086
    ## 4:      test incongruent 300 0.9161367 0.4414236 0.02548561 0.05015388

``` r
avg_conditionCongruency <- data[, .(acc = mean(acc, na.rm = T),
                                    rt = mean(rt, na.rm = T)), by = .(pNo, condition, congruency)]

plot_rt <- ggplot(grandAvg_conditionCongruency$rt, aes(condition, rt, col = congruency)) +
    geom_quasirandom(data = avg_conditionCongruency, aes(condition, rt, col = congruency), alpha = 0.4) +
    geom_point(position = position_dodge(0.5), size = 3) +
    geom_errorbar(aes(ymin = rt - ci, ymax = rt + ci), position = position_dodge(0.5), width = 0, size = 1) +
    labs(x = "Experimental condition", y = "Reaction time (95% CI)", col = "Stroop congruency")
plot_rt
```

![](Tutorial_with_real_Stroop_data_files/figure-markdown_github/stroop%20rt%20by%20condition%20and%20congruency-1.png)

``` r
model_rt <- lmer(rt ~ condition * congruency + (1 | pNo), data = data)
summary(model_rt)
```

    ## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
    ## lmerModLmerTest]
    ## Formula: rt ~ condition * congruency + (1 | pNo)
    ##    Data: data
    ## 
    ## REML criterion at convergence: 3374.7
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -1.6649 -0.3686 -0.1567  0.1492 16.0245 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev.
    ##  pNo      (Intercept) 0.01909  0.1382  
    ##  Residual             0.37571  0.6130  
    ## Number of obs: 1800, groups:  pNo, 5
    ## 
    ## Fixed effects:
    ##                                       Estimate Std. Error         df
    ## (Intercept)                            0.78268    0.06666    4.87243
    ## conditiontest                         -0.01135    0.03539 1792.00000
    ## congruencyincongruent                  0.30670    0.04334 1792.00000
    ## conditiontest:congruencyincongruent   -0.16189    0.06130 1792.00000
    ##                                     t value Pr(>|t|)    
    ## (Intercept)                          11.742 9.29e-05 ***
    ## conditiontest                        -0.321  0.74842    
    ## congruencyincongruent                 7.076 2.12e-12 ***
    ## conditiontest:congruencyincongruent  -2.641  0.00833 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) cndtnt cngrnc
    ## conditintst -0.265              
    ## cngrncyncng -0.217  0.408       
    ## cndtntst:cn  0.153 -0.577 -0.707

``` r
summaryh(model_rt)
```

    ##                                   term
    ## 1:                         (Intercept)
    ## 2:                       conditiontest
    ## 3:               congruencyincongruent
    ## 4: conditiontest:congruencyincongruent
    ##                                                       results
    ## 1:      b = 0.78, SE = 0.07, t(5) = 11.74, p < .001, r = 0.98
    ## 2: b = −0.01, SE = 0.04, t(1792) = −0.32, p = .748, r = 0.008
    ## 3:    b = 0.31, SE = 0.04, t(1792) = 7.08, p < .001, r = 0.16
    ## 4:  b = −0.16, SE = 0.06, t(1792) = −2.64, p = .008, r = 0.06

``` r
plot_acc <- ggplot(grandAvg_conditionCongruency$acc, aes(condition, acc, col = congruency)) +
    geom_quasirandom(data = avg_conditionCongruency, aes(condition, acc, col = congruency), alpha = 0.4) +
    geom_point(position = position_dodge(0.5), size = 3) +
    geom_errorbar(aes(ymin = acc - ci, ymax = acc + ci), position = position_dodge(0.5), width = 0, size = 1) +
    labs(x = "Experimental condition", y = "Accuracy (95% CI)", col = "Stroop congruency")
plot_acc
```

![](Tutorial_with_real_Stroop_data_files/figure-markdown_github/stroop%20acc%20by%20condition%20and%20congruency-1.png)

``` r
model_acc <- glmer(acc ~ condition * congruency + (1 | pNo), data = data, family = 'binomial')
summary(model_acc)
```

    ## Generalized linear mixed model fit by maximum likelihood (Laplace
    ##   Approximation) [glmerMod]
    ##  Family: binomial  ( logit )
    ## Formula: acc ~ condition * congruency + (1 | pNo)
    ##    Data: data
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##    710.7    737.9   -350.4    700.7     1694 
    ## 
    ## Scaled residuals: 
    ##      Min       1Q   Median       3Q      Max 
    ## -11.5967   0.0954   0.1770   0.2502   0.6775 
    ## 
    ## Random effects:
    ##  Groups Name        Variance Std.Dev.
    ##  pNo    (Intercept) 0.298    0.5459  
    ## Number of obs: 1699, groups:  pNo, 5
    ## 
    ## Fixed effects:
    ##                                     Estimate Std. Error z value Pr(>|z|)
    ## (Intercept)                           4.4195     0.4341  10.182  < 2e-16
    ## conditiontest                        -1.2881     0.4056  -3.176  0.00149
    ## congruencyincongruent                -1.9219     0.4168  -4.611 4.01e-06
    ## conditiontest:congruencyincongruent   0.3846     0.4879   0.788  0.43045
    ##                                        
    ## (Intercept)                         ***
    ## conditiontest                       ** 
    ## congruencyincongruent               ***
    ## conditiontest:congruencyincongruent    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) cndtnt cngrnc
    ## conditintst -0.715              
    ## cngrncyncng -0.696  0.743       
    ## cndtntst:cn  0.590 -0.830 -0.854

``` r
summaryh(model_acc)
```

    ##                                   term
    ## 1:                         (Intercept)
    ## 2:                       conditiontest
    ## 3:               congruencyincongruent
    ## 4: conditiontest:congruencyincongruent
    ##                                                       results
    ## 1:   b = 4.42, SE = 0.43, z(1694) = 10.18, p < .001, r = 0.77
    ## 2: b = −1.29, SE = 0.41, z(1694) = −3.18, p = .002, r = −0.33
    ## 3: b = −1.92, SE = 0.42, z(1694) = −4.61, p < .001, r = −0.47
    ## 4:    b = 0.38, SE = 0.49, z(1694) = 0.79, p = .430, r = 0.11
