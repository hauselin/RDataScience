R Basics
================
Hause Lin
2018-01-20

Set current working directory
=============================

The **working directory** (also known as current working directory) is the folder you're currently in. If you're navigating your computer with your mouse, you'll be clicking and moving into different folders. Directory is just a different way of saying 'location' or where you're at right now (which folder you're currently in).

To set your working directory, first find and copy the path (the long string of characters/letters such as "Users/John/Desktop/Projects/") to your current working directory. You might want to create a new folder on your computer for each new project, and then copy the path to this folder or directory. After you've copied the directory path, let R know you want this to be your working directory by using the `setwd()` function (setwd: "set working directory"). The path to my directory is "/Users/Hause/Dropbox/Working Projects/RDataScience/R Basics/".

``` r
setwd("/Users/Hause/Dropbox/Working Projects/RDataScience/R Basics/")
```

To get print your current working directory in RStudio's console, use `getwd()`

``` r
getwd() # get working directory
```

    ## [1] "/Users/Hause/Dropbox/Working Projects/RDataScience/R Basics"

Variables and vectors... and classes
====================================

``` r
variable1 <- 10
variable2 <- 200
v3 <- variable1 + variable2

variable1; variable2; v3 # print variables to console
```

    ## [1] 10

    ## [1] 200

    ## [1] 210

**Vectors** are objects that store data of the same **class**

``` r
c(1, 3, 5) # numeric
```

    ## [1] 1 3 5

``` r
c("I am happy", "I am sad", "I am ambivalent") # character
```

    ## [1] "I am happy"      "I am sad"        "I am ambivalent"

``` r
c(TRUE, FALSE) # logical (boolean TRUE/FALSE)
```

    ## [1]  TRUE FALSE

Installing and loading packages/libraries
=========================================

You only have to install packages once!

``` r
# install.packages(c("tidyverse", "data.table", "dtplyr", "lme4", "lmerTest", "ggbeeswarm", "cowplot"))
```

To load libraries, use `library(library_name_you_want_to_load)`

``` r
library(tidyverse); library(data.table);library(broom); library(dtplyr); library(cowplot); library(lme4); library(lmerTest); library(ggbeeswarm)
```

Reading files into R
====================

``` r
df1 <- read.csv("./Datasets/Orange.csv")
df2 <- fread("./Datasets/Orange.csv")
df3 <- tbl_dt(fread("./Datasets/Orange.csv"))

df1 # read.csv(csv)
```

    ##    Tree  age circumference
    ## 1     1  118            30
    ## 2     1  484            58
    ## 3     1  664            87
    ## 4     1 1004           115
    ## 5     1 1231           120
    ## 6     1 1372           142
    ## 7     1 1582           145
    ## 8     2  118            33
    ## 9     2  484            69
    ## 10    2  664           111
    ## 11    2 1004           156
    ## 12    2 1231           172
    ## 13    2 1372           203
    ## 14    2 1582           203
    ## 15    3  118            30
    ## 16    3  484            51
    ## 17    3  664            75
    ## 18    3 1004           108
    ## 19    3 1231           115
    ## 20    3 1372           139
    ## 21    3 1582           140
    ## 22    4  118            32
    ## 23    4  484            62
    ## 24    4  664           112
    ## 25    4 1004           167
    ## 26    4 1231           179
    ## 27    4 1372           209
    ## 28    4 1582           214
    ## 29    5  118            30
    ## 30    5  484            49
    ## 31    5  664            81
    ## 32    5 1004           125
    ## 33    5 1231           142
    ## 34    5 1372           174
    ## 35    5 1582           177

``` r
df2 # fread(csv)
```

    ##     Tree  age circumference
    ##  1:    1  118            30
    ##  2:    1  484            58
    ##  3:    1  664            87
    ##  4:    1 1004           115
    ##  5:    1 1231           120
    ##  6:    1 1372           142
    ##  7:    1 1582           145
    ##  8:    2  118            33
    ##  9:    2  484            69
    ## 10:    2  664           111
    ## 11:    2 1004           156
    ## 12:    2 1231           172
    ## 13:    2 1372           203
    ## 14:    2 1582           203
    ## 15:    3  118            30
    ## 16:    3  484            51
    ## 17:    3  664            75
    ## 18:    3 1004           108
    ## 19:    3 1231           115
    ## 20:    3 1372           139
    ## 21:    3 1582           140
    ## 22:    4  118            32
    ## 23:    4  484            62
    ## 24:    4  664           112
    ## 25:    4 1004           167
    ## 26:    4 1231           179
    ## 27:    4 1372           209
    ## 28:    4 1582           214
    ## 29:    5  118            30
    ## 30:    5  484            49
    ## 31:    5  664            81
    ## 32:    5 1004           125
    ## 33:    5 1231           142
    ## 34:    5 1372           174
    ## 35:    5 1582           177
    ##     Tree  age circumference

``` r
df3 # tb_dt(fread(csv))
```

    ## Source: local data table [35 x 3]
    ## 
    ## # A tibble: 35 x 3
    ##    Tree    age circumference
    ##    <chr> <int>         <int>
    ##  1 1       118            30
    ##  2 1       484            58
    ##  3 1       664            87
    ##  4 1      1004           115
    ##  5 1      1231           120
    ##  6 1      1372           142
    ##  7 1      1582           145
    ##  8 2       118            33
    ##  9 2       484            69
    ## 10 2       664           111
    ## # ... with 25 more rows

``` r
# rmarkdown::render("R Basics.R", "github_document")
```
