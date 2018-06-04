Tutorial 1 R and programming basics
================

Data science
------------

-   Cleaning, wrangling, and munging data
-   Summarizing and visualizing data
-   Fitting models to data
-   Evaluating fitted models

Installing R packages/libraries
-------------------------------

Use the `install.packages()` function to install packages from CRAN (The Comprehensive R Archive Network), which hosts official releases of different packages (also known as libraries) written by R users (people like you and I can write these packages).

Install packages once and you'll have them on your computer. You only need to update them regularly in the future. No need to rerun `install.packages()` every time you want to use these packages.

``` r
# install one by one
install.packages("tidyverse")
install.packages("data.table")
install.packages("broom")
install.packages("dtplyr")
install.packages("lme4")
install.packages("lmerTest")
install.packages("ggbeeswarm")
install.packages("cowplot")
install.packages("piecewiseSEM")
install.packages("compute.es")
install.packages("sjstats")
install.packages("sjPlot")

# or install all at once
#' I have commented out (added a # sign in front of a line)
#' the line of code below so I won't run it accidentally,
#' or it's to tell myself or others who are reading my code,
#' that I usually don't intend to run this line of code
#' unless I really want to.
install.packages(c("tidyverse", "data.table", "broom", "dtplyr", "lme4", "lmerTest", "ggbeeswarm", "cowplot", "piecewiseSEM", "compute.es", "sjstats", "sjPlot"))
```

Using/loading R packages when you begin a new RStudio session
-------------------------------------------------------------

Use `library()` to load packages and use semi-colon (;) to load multiple packages in the same line. I always load the packages below whenever I start a new RStudio session. Sometimes you'll see people using `require()` instead of `library()`. Both works!

``` r
library(tidyverse); library(data.table); library(broom); library(dtplyr); library(lme4); library(lmerTest); library(ggbeeswarm); library(cowplot)
```

Working/current directory: Where are you and where should you be?
-----------------------------------------------------------------

The **working directory** (also known as current directory) is the folder (also known as directory) you're currently in. If you're navigating your computer with your mouse, you'll be clicking and moving into different folders. Directory is just a different way of saying 'location' or where you're at right now (which folder you're currently in).

``` r
getwd() # this function prints in the console your current working directory (get working directory)
```

    ## [1] "/Users/Hause/Dropbox/Working Projects/RDataScience"

The path above tells you where your working directory is now. It's conceptually equivalent to you opening a window and using your mouse to manually navigate to that folder.

To change your working directory (to where your project folder is located), use the `setwd()`. This function is easy to use, but the difficulty for most beginners is getting the path to your folder (e.g., "/Users/Hause/Dropbox/Working Projects/RDataScience") so you can specify something like `setwd("/Users/Hause/Dropbox/Working Projects/RDataScience")`.

#### Two ways to change/set your working directory.

1.  Go to your menubar (at the top). Click **Help** and search for **set working directory**. RStudio will tell you how to do it via the **Session** menu. Select **Set Working Directory** and **Choose Directory**. Then navigate to your project directory and you're done.

2.  On one of the RStudio panes, you'll see a **Files** tab (click on it). Use that pane to navigate to your project directory. When you're there, click **More** and **Set As Working Directory**.

Whether you choose method 1 or 2, you should see your new directory being set in the console panel, which should look something like `> setwd("your/path/is/here")`. **COPY AND PASTE THIS OUTPUT (but without the &gt;) to your current script**. So you should be copying something like this:

``` r
setwd("your/path/is/here")
```

Good practices
--------------

-   One directory/folder per project
-   Clear your environment and set your working directory at the top of each script
-   Load your libraries at the top of each script
-   Save and restore your work with `save.image()` and `load()`
-   Give your variables and objects sensible names
