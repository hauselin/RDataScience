Tutorial 2: tidyverse and datatable
================
Hause Lin

-   [Reading data into R](#reading-data-into-r)
-   [Comparing the outputs of read.csv(x), fread(x), and tbl\_dt(fread(x))](#comparing-the-outputs-of-read.csvx-freadx-and-tbl_dtfreadx)
    -   [Reading URLs and other formats](#reading-urls-and-other-formats)

![Caption for the picture.](./Images/long_to_wide.png)

``` r
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
```

Reading data into R
-------------------

``` r
df1 <- read.csv("./Data/sleep.csv") # base R read.csv() function
# same as df1 <- read.csv("Data/sleep.csv")

df2 <- fread("./Data/sleep.csv") # fread() from library(data.table)
# same as df2 <- fread("Data/sleep.csv")

# my favorite way of reading data: combining tbl_dt() and fread()
df3 <- tbl_dt(fread("./Data/sleep.csv")) # tbl_dt() from library(dtplyr)
# same as df3 <- tbl_dt(fread("Data/sleep.csv"))
```

Comparing the outputs of read.csv(x), fread(x), and tbl\_dt(fread(x))
---------------------------------------------------------------------

The `.` in the file path simply refers to the current working directory, so it can be dropped. And `..` can be used to refer to the parent directory.

``` r
df1 # read.csv("./Data/sleep.csv")
```

    ##    extra group ID
    ## 1    0.7     1  1
    ## 2   -1.6     1  2
    ## 3   -0.2     1  3
    ## 4   -1.2     1  4
    ## 5   -0.1     1  5
    ## 6    3.4     1  6
    ## 7    3.7     1  7
    ## 8    0.8     1  8
    ## 9    0.0     1  9
    ## 10   2.0     1 10
    ## 11   1.9     2  1
    ## 12   0.8     2  2
    ## 13   1.1     2  3
    ## 14   0.1     2  4
    ## 15  -0.1     2  5
    ## 16   4.4     2  6
    ## 17   5.5     2  7
    ## 18   1.6     2  8
    ## 19   4.6     2  9
    ## 20   3.4     2 10

``` r
class(df1) # read.csv("./Data/sleep.csv")
```

    ## [1] "data.frame"

``` r
df2 # fread("./Data/sleep.csv") # fread() from library(data.table)
```

    ##     extra group ID
    ##  1:   0.7     1  1
    ##  2:  -1.6     1  2
    ##  3:  -0.2     1  3
    ##  4:  -1.2     1  4
    ##  5:  -0.1     1  5
    ##  6:   3.4     1  6
    ##  7:   3.7     1  7
    ##  8:   0.8     1  8
    ##  9:   0.0     1  9
    ## 10:   2.0     1 10
    ## 11:   1.9     2  1
    ## 12:   0.8     2  2
    ## 13:   1.1     2  3
    ## 14:   0.1     2  4
    ## 15:  -0.1     2  5
    ## 16:   4.4     2  6
    ## 17:   5.5     2  7
    ## 18:   1.6     2  8
    ## 19:   4.6     2  9
    ## 20:   3.4     2 10

``` r
class(df2) # fread("./Data/sleep.csv") # fread() from library(data.table)
```

    ## [1] "data.table" "data.frame"

How's the output different from the one above?

``` r
df3 # tbl_dt(fread("./Data/sleep.csv")) # tbl_dt() from library(dtplyr)
```

    ## Source: local data table [20 x 3]
    ## 
    ## # A tibble: 20 x 3
    ##    extra group    ID
    ##    <dbl> <int> <int>
    ##  1   0.7     1     1
    ##  2  -1.6     1     2
    ##  3  -0.2     1     3
    ##  4  -1.2     1     4
    ##  5  -0.1     1     5
    ##  6   3.4     1     6
    ##  7   3.7     1     7
    ##  8   0.8     1     8
    ##  9   0       1     9
    ## 10   2       1    10
    ## 11   1.9     2     1
    ## 12   0.8     2     2
    ## 13   1.1     2     3
    ## 14   0.1     2     4
    ## 15  -0.1     2     5
    ## 16   4.4     2     6
    ## 17   5.5     2     7
    ## 18   1.6     2     8
    ## 19   4.6     2     9
    ## 20   3.4     2    10

``` r
class(df3) # tbl_dt(fread("./Data/sleep.csv")) # tbl_dt() from library(dtplyr)
```

    ## [1] "tbl_dt"     "tbl"        "data.table" "data.frame"

How's the output different from the two outputs above?

### Reading URLs and other formats

Check out the csv (comma separated values) data [here](https://raw.githubusercontent.com/hauselin/RDataScience/master/Data/sleep.csv). You can read data directly off a website.

Most of these read functions can import/read different types of files (e.g., csv, txt, URLs) as long as the raw data are formatted properly (e.g., separated by commas, tabs). But if you're trying to read proprietary data formats (e.g., SPSS datasets, Excel sheets), you'll need to use other libraries (e.g., `readxl`, `foreign`) to read those data into R.

``` r
df_url <- tbl_dt(fread("https://raw.githubusercontent.com/hauselin/RDataScience/master/Data/sleep.csv"))
df_url # print data to console; same dataset as tbl_dt(fread("./Data/sleep.csv"))
```

    ## Source: local data table [20 x 3]
    ## 
    ## # A tibble: 20 x 3
    ##    extra group    ID
    ##    <dbl> <int> <int>
    ##  1   0.7     1     1
    ##  2  -1.6     1     2
    ##  3  -0.2     1     3
    ##  4  -1.2     1     4
    ##  5  -0.1     1     5
    ##  6   3.4     1     6
    ##  7   3.7     1     7
    ##  8   0.8     1     8
    ##  9   0       1     9
    ## 10   2       1    10
    ## 11   1.9     2     1
    ## 12   0.8     2     2
    ## 13   1.1     2     3
    ## 14   0.1     2     4
    ## 15  -0.1     2     5
    ## 16   4.4     2     6
    ## 17   5.5     2     7
    ## 18   1.6     2     8
    ## 19   4.6     2     9
    ## 20   3.4     2    10
