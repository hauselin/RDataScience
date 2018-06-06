Tutorial 2: tidyverse and datatable
================
Hause Lin

-   [Reading data into R](#reading-data-into-r)
-   [Comparing the outputs of read.csv(x), fread(x), and tbl\_dt(fread(x))](#comparing-the-outputs-of-read.csvx-freadx-and-tbl_dtfreadx)
    -   [Reading URLs and other formats](#reading-urls-and-other-formats)
-   [Summarizing objects](#summarizing-objects)
-   [Using `$` and `[]` to extract elements using their names.](#using-and-to-extract-elements-using-their-names.)
-   [tidyverse: a collection of R packages](#tidyverse-a-collection-of-r-packages)
-   [Supercharging your workflow with data.table()](#supercharging-your-workflow-with-data.table)

``` r
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
```

Reading data into R
-------------------

Read file in a directory and save the data as an object in the environment by using the assignment `<-` operator.

``` r
df1 <- read.csv("./Data/sleep.csv") # base R read.csv() function
# same as df1 <- read.csv("Data/sleep.csv")
# READ: assign the output read.csv("Data/sleep.csv") into df1

df2 <- fread("./Data/sleep.csv") # fread() from library(data.table)
# same as df2 <- fread("Data/sleep.csv")

# my favorite way of reading data: combining tbl_dt() and fread()
df3 <- tbl_dt(fread("./Data/sleep.csv")) # tbl_dt() from library(dtplyr)
# same as df3 <- tbl_dt(fread("Data/sleep.csv"))
```

The `.` in the file path simply refers to the current working directory, so it can be dropped. And `..` can be used to refer to the parent directory.

Comparing the outputs of read.csv(x), fread(x), and tbl\_dt(fread(x))
---------------------------------------------------------------------

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

Summarizing objects
-------------------

You can summarize objects quickly by using `summary()`, `str()`, `glimpse()`, or `print(x, n)`.

To view the first/last few items of an object, use `head()` or `tail()`.

``` r
summary(df1) # we use summary() for many many other purposes
```

    ##      extra            group           ID      
    ##  Min.   :-1.600   Min.   :1.0   Min.   : 1.0  
    ##  1st Qu.:-0.025   1st Qu.:1.0   1st Qu.: 3.0  
    ##  Median : 0.950   Median :1.5   Median : 5.5  
    ##  Mean   : 1.540   Mean   :1.5   Mean   : 5.5  
    ##  3rd Qu.: 3.400   3rd Qu.:2.0   3rd Qu.: 8.0  
    ##  Max.   : 5.500   Max.   :2.0   Max.   :10.0

``` r
str(df1) 
```

    ## 'data.frame':    20 obs. of  3 variables:
    ##  $ extra: num  0.7 -1.6 -0.2 -1.2 -0.1 3.4 3.7 0.8 0 2 ...
    ##  $ group: int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ ID   : int  1 2 3 4 5 6 7 8 9 10 ...

``` r
glimpse(df1)
```

    ## Observations: 20
    ## Variables: 3
    ## $ extra <dbl> 0.7, -1.6, -0.2, -1.2, -0.1, 3.4, 3.7, 0.8, 0.0, 2.0, 1....
    ## $ group <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
    ## $ ID    <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 7, 8, 9...

``` r
head(df1)
```

    ##   extra group ID
    ## 1   0.7     1  1
    ## 2  -1.6     1  2
    ## 3  -0.2     1  3
    ## 4  -1.2     1  4
    ## 5  -0.1     1  5
    ## 6   3.4     1  6

``` r
head(df3, n = 3) # what does this do?
```

    ## Source: local data table [3 x 3]
    ## 
    ## # A tibble: 3 x 3
    ##   extra group    ID
    ##   <dbl> <int> <int>
    ## 1   0.7     1     1
    ## 2  -1.6     1     2
    ## 3  -0.2     1     3

``` r
tail(df3, n = 2)
```

    ## Source: local data table [2 x 3]
    ## 
    ## # A tibble: 2 x 3
    ##   extra group    ID
    ##   <dbl> <int> <int>
    ## 1   4.6     2     9
    ## 2   3.4     2    10

``` r
print(df3, n = Inf) # Inf is infinte (so print all rows)
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

Use pipes `%>%` to summarize objects

``` r
df3 %>% head(n = 2)
```

    ## Source: local data table [2 x 3]
    ## 
    ## # A tibble: 2 x 3
    ##   extra group    ID
    ##   <dbl> <int> <int>
    ## 1   0.7     1     1
    ## 2  -1.6     1     2

``` r
df3 %>% head(2) # why does this work?
```

    ## Source: local data table [2 x 3]
    ## 
    ## # A tibble: 2 x 3
    ##   extra group    ID
    ##   <dbl> <int> <int>
    ## 1   0.7     1     1
    ## 2  -1.6     1     2

``` r
df3 %>% print(Inf)
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
df3 %>% summary() # does this work? why?
```

    ##      extra            group           ID      
    ##  Min.   :-1.600   Min.   :1.0   Min.   : 1.0  
    ##  1st Qu.:-0.025   1st Qu.:1.0   1st Qu.: 3.0  
    ##  Median : 0.950   Median :1.5   Median : 5.5  
    ##  Mean   : 1.540   Mean   :1.5   Mean   : 5.5  
    ##  3rd Qu.: 3.400   3rd Qu.:2.0   3rd Qu.: 8.0  
    ##  Max.   : 5.500   Max.   :2.0   Max.   :10.0

Datatables and `dplyr`'s data\_frame are much better because they tell us the class of each variable at the top when you print the object in the console. They also tell you the dimensions of your data.

``` r
df3 # data_frame (dplyr) + data.table + tibble
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

Using `$` and `[]` to extract elements using their names.
---------------------------------------------------------

``` r
names(df3)
```

    ## [1] "extra" "group" "ID"

``` r
df3$extra # extracts column/variable as a vector
```

    ##  [1]  0.7 -1.6 -0.2 -1.2 -0.1  3.4  3.7  0.8  0.0  2.0  1.9  0.8  1.1  0.1
    ## [15] -0.1  4.4  5.5  1.6  4.6  3.4

``` r
df3$group
```

    ##  [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2

``` r
df3$ID
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10  1  2  3  4  5  6  7  8  9 10

``` r
myList <- list(a = -999, b = c(TRUE, FALSE, T, T), c = c('myAmazingList')) # create a list with named items a, b, c
class(myList)
```

    ## [1] "list"

``` r
names(myList) 
```

    ## [1] "a" "b" "c"

``` r
myList # note the formatting/structure of a list ($ signs tell you how to extract items)
```

    ## $a
    ## [1] -999
    ## 
    ## $b
    ## [1]  TRUE FALSE  TRUE  TRUE
    ## 
    ## $c
    ## [1] "myAmazingList"

``` r
myList$a
```

    ## [1] -999

``` r
myList$b # lists can store objects of different classes (unlike most other objects, which expect all items to be of same class)
```

    ## [1]  TRUE FALSE  TRUE  TRUE

``` r
myList$c
```

    ## [1] "myAmazingList"

``` r
df1['extra'] # same as df$extra, but uses characters (in '') to extract elements
```

    ##    extra
    ## 1    0.7
    ## 2   -1.6
    ## 3   -0.2
    ## 4   -1.2
    ## 5   -0.1
    ## 6    3.4
    ## 7    3.7
    ## 8    0.8
    ## 9    0.0
    ## 10   2.0
    ## 11   1.9
    ## 12   0.8
    ## 13   1.1
    ## 14   0.1
    ## 15  -0.1
    ## 16   4.4
    ## 17   5.5
    ## 18   1.6
    ## 19   4.6
    ## 20   3.4

\*\* BUT the syntax above only works for the `data.frame` class!\*\*

``` r
df3['extra'] # fails!!!
```

    ## Error in `[.data.table`(df3, "extra"): When i is a data.table (or character vector), the columns to join by must be specified either using 'on=' argument (see ?data.table) or by keying x (i.e. sorted, and, marked as sorted, see ?setkey). Keyed joins might have further speed benefits on very large data due to x being sorted in RAM.

If it's a `data.table` class, you do it differently (so know the classes of your objects)! More on `data.table` later on.

``` r
df3[, extra] # df3[i, j] (i is row, and j is column)
```

    ##  [1]  0.7 -1.6 -0.2 -1.2 -0.1  3.4  3.7  0.8  0.0  2.0  1.9  0.8  1.1  0.1
    ## [15] -0.1  4.4  5.5  1.6  4.6  3.4

tidyverse: a collection of R packages
-------------------------------------

[tidyverse:](https://www.tidyverse.org/packages/)

> The tidyverse is an opinionated collection of R packages designed for data science. All packages share an underlying design philosophy, grammar, and data structures.

Included packages: `ggplot2`, `dplyr`, `tidyr`, `stringr` etc. [see official website for documentation](https://www.tidyverse.org/packages/)

``` r
library(tidyverse)
```

Supercharging your workflow with data.table()
---------------------------------------------
