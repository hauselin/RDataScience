# Data Science with R for Psychologists

### Install R packages

I use a few R packages regularly. To install all of them, first make sure you have the latest version of R and RStudio. Then to install packages, run the following code in R or RStudio. You only need to install any given package once (but remember to update them when newer versions are available).

You can install one package at a time or multiple at once. I suggest installing one at a time because it can be can be error-prone if you try to install too many packages at once because the warning/error messages can become difficult quite abstruse (if there are any).

```
# install one by one
install.packages("tidyverse")
install.packages("data.table")
install.packages("broom")
install.packages("dtplyr")
install.packages("lme4")
install.packages("lmerTest")
install.packages("ggbeeswarm")
install.packages("cowplot")

# or install all at once
#' I have commented out (added a # sign in front of a line)
#' the line of code below so I won't run it accidentally,
#' or it's to tell myself or others who are reading my code,
#' that I usually don't intend to run this line of code
#' unless I really want to.
# install.packages(c("tidyverse", "data.table", "broom", "dtplyr", "lme4", "lmerTest", "ggbeeswarm", "cowplot"))
```

Other useful packages I use in my [custom functions](#custorm-r-functions)

```
install.packages("piecewiseSEM") 
install.packages("compute.es")
install.packages("sjstats")
```

Every time I start a new R session in RStudio, I usually run this line of code somewhere at the top of my R script to load all these libraries all at once.

```
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
```

These R packages above are very powerful and it's worth learning them well.

* [tidyverse](https://www.tidyverse.org/) packages (e.g., dplyr, tidyr, ggplot2, stringr)
    - manipulate dataframes (and tibbles) easily with tidyr, dplyr
    - make beautiful plots with clean syntax (ggplot2)
* [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
    - powerful, extremely fast, and simple way to manipulate dataframes/datatables
* [broom](https://cran.r-project.org/web/packages/broom/vignettes/broom.html)
    - converts model outputs into tidy dataframes
* [dtplyr](https://github.com/hadley/dtplyr)
    - `tbl_dt()` function from this package combines the best of tidyverse and data.table packages
* [lme4](https://www.jaredknowles.com/journal/2013/11/25/getting-started-with-mixed-effect-models-in-r)
    - fit linear mixed effects models
* [lmerTest](https://cran.r-project.org/web/packages/lmerTest/index.html)
    - compute probability values and degrees of freedom for mixed effects models fitted using lme4 package (uses Satterthwaite approximation)
* [ggbeeswarm](https://github.com/eclarke/ggbeeswarm)
    - produces beautiful and informative ggplots that show distributions of datapoints
* [cowplot](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html)
    - combines multiple ggplots into one plot

### Custom R functions

I have written and adapted many R functions to make my workflow more efficient. Check out my [other github repository](https://github.com/hauselin/Rcode).
