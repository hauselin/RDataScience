Tutorial 2: tidyverse and datatable
================
Hause Lin

-   [Reading data into R](#reading-data-into-r)
-   [Comparing the outputs of read.csv(x), fread(x), and tbl\_dt(fread(x))](#comparing-the-outputs-of-read.csvx-freadx-and-tbl_dtfreadx)

``` r
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
```

Reading data into R
-------------------

``` r
df1 <- read.csv("./Data/Orange.csv") # base R read.csv() function
# same as df1 <- read.csv("Data/Orange.csv")

df2 <- fread("./Data/Orange.csv") # fread() from library(data.table)
# same as df2 <- fread("Data/Orange.csv")

# my favorite way of reading data: combining tbl_dt() and fread()
df3 <- tbl_dt(fread("./Data/Orange.csv")) # tbl_dt() from library(dtplyr)
# same as df3 <- tbl_dt(fread("Data/Orange.csv"))
```

Comparing the outputs of read.csv(x), fread(x), and tbl\_dt(fread(x))
---------------------------------------------------------------------

The `.` in the file path simply refers to the current working directory, so it can be dropped. And `..` can be used to refer to the parent directory.

``` r
df1 # read.csv("./Data/Orange.csv")
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
df2 # fread("./Data/Orange.csv") # fread() from library(data.table)
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

How's the output different from the one above?

``` r
df3 # tbl_dt(fread("./Data/Orange.csv")) # tbl_dt() from library(dtplyr)
```

    ## Source: local data table [35 x 3]
    ## 
    ## # A tibble: 35 x 3
    ##     Tree   age circumference
    ##    <int> <int>         <int>
    ##  1     1   118            30
    ##  2     1   484            58
    ##  3     1   664            87
    ##  4     1  1004           115
    ##  5     1  1231           120
    ##  6     1  1372           142
    ##  7     1  1582           145
    ##  8     2   118            33
    ##  9     2   484            69
    ## 10     2   664           111
    ## # ... with 25 more rows

How's the output different from the two outputs above?

``` r
class(df1) # read.csv("./Data/Orange.csv")
```

    ## [1] "data.frame"

``` r
class(df2) # fread("./Data/Orange.csv") # fread() from library(data.table)
```

    ## [1] "data.table" "data.frame"

``` r
class(df3) # tbl_dt(fread("./Data/Orange.csv")) # tbl_dt() from library(dtplyr)
```

    ## [1] "tbl_dt"     "tbl"        "data.table" "data.frame"
