# Data Science with R for Psychologists

## Installing (or updating) R and RStudio

Download R [here](https://www.r-project.org/). Follow the instructions under **Getting Started** to download R. Choose a mirror/location that is closest to you and download R for Linux, Mac, or Windows.

* R is a programming language and an environment. It doesn't look too good and isn't too user-friendly. We generally use RStudio as a pretty and user-friendly interface to R.

Download RStudio [here](https://www.rstudio.com/products/rstudio/download/) (the FREE version).

After installing both R and RStudio, run RStudio. We usually never use R itself and always run RStudio (RStudio relies on R). R is like your new but empty home (without furnitures and quite unlivable unless you're a real minimalist) and RStudio are like furniture and decorations added to your house (R), making your house much more livable and even pretty. Thus, RStudio is useless without R, just like furniture and decorations are useless if you don't already have a house. 

**Updating R and RStudio once every few months**

* You should check whether there are newer versions of R and RStudio at least once every few months and install them if available. It's good practice to always use the latest versions. Just go to their websites and download and re-install them again.

## Installing R packages

I use a few R packages regularly. To install all of them, first make sure you have the latest version of R and RStudio. Then to install packages, run the following code in RStudio. You only need to install any given package once (but remember to update them when newer versions are available).

You can install one package at a time or multiple at once. I suggest installing one at a time because it can be can be error-prone if you try to install too many packages at once because the warning/error messages can become difficult quite abstruse (if there are any).

```
# install packages all at once using c()
install.packages(c("tidyverse", "data.table", "broom", "dtplyr", "lme4", "lmerTest", "ggbeeswarm", "cowplot", "piecewiseSEM", "compute.es", "sjstats", "sjPlot"))

# install one by one
#' I have commented out (added a # sign in front of a line)
#' the line of code below so I won't run it accidentally,
#' or it's to tell myself or others who are reading my code,
#' that I usually don't intend to run this line of code
#' unless I really want to.
# install.packages("tidyverse")
# install.packages("data.table")
# install.packages("broom")
# install.packages("dtplyr")
# install.packages("lme4")
# install.packages("lmerTest")
# install.packages("ggbeeswarm")
# install.packages("cowplot")
# install.packages("piecewiseSEM")
# install.packages("compute.es")
# install.packages("sjstats")
# install.packages("sjPlot")
```

I use many of these packages in my [custom functions](#custom-r-functions) (although when you use these functions, they'll try to install these packages if you don't already have them).

Every time I start a new R session in RStudio, I usually run this line of code somewhere at the top of my R script to load all these libraries all at once using `library()`.

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
* [cowplot](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html)

## My custom R functions

I have written and adapted many R functions to make my workflow more efficient. Check out my [other github repository](https://github.com/hauselin/Rcode).
