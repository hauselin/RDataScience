#' ---
#' title: "R Basics"
#' author: "Hause Lin"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

#' # Set current working directory
#' 
#' The **working directory** (also known as current working directory) is the folder you're currently in. If you're navigating your computer with your mouse, you'll be clicking and moving into different folders. Directory is just a different way of saying 'location' or where you're at right now (which folder you're currently in). 
#' 
#' To set your working directory, first find and copy the path (the long string of characters/letters such as "Users/John/Desktop/Projects/") to your current working directory. You might want to create a new folder on your computer for each new project, and then copy the path to this folder or directory. After you've copied the directory path, let R know you want this to be your working directory by using the `setwd()` function (setwd: "set working directory"). The path to my directory is "/Users/Hause/Dropbox/Working Projects/RDataScience/R Basics/".

setwd("/Users/Hause/Dropbox/Working Projects/RDataScience/R Basics/")

#' To get print your current working directory in RStudio's console, use `getwd()`

getwd() # get working directory

#' # Variables and vectors... and classes

variable1 <- 10
variable2 <- 200
v3 <- variable1 + variable2

variable1; variable2; v3 # print all 4 variables to console

#' **Vectors** are objects that store data of the same **class**

c(1, 3, 5) # numeric
c("I am happy", "I am sad", "I am ambivalent") # character
c(TRUE, FALSE) # logical (boolean TRUE/FALSE)

#' # Installing and loading packages/libraries
#'
#' You only have to install packages once!

# install.packages(c("tidyverse", "data.table", "dtplyr", "lme4", "lmerTest", "ggbeeswarm", "cowplot"))

#' To load libraries, use `library(library_name_you_want_to_load)`
library(tidyverse); library(data.table);library(broom); library(dtplyr); library(cowplot); library(lme4); library(lmerTest); library(ggbeeswarm)

#' # Reading files into R
#' 




#' A script comment that includes **markdown** formatting.


ggplot(mtcars, aes(cyl, mpg)) +
    geom_point()




# rmarkdown::render("R Basics.R", "github_document")