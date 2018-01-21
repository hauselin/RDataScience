#' ---
#' title: "R Basics"
#' author: "Hause Lin"
#' date: "`r format(Sys.Date())`"
#' output: github_document
#' ---

#' # Set current working directory
#' The working directory (also known as current working directory) is the folder you're currently in. If you're navigating your computer with your mouse, you'll be clicking and moving into different folders. Directory is just a different way of saying 'location' or where you're at right now (which folder you're currently in). 
#' 
#' To set your working directory, first find and copy the path (the long string of characters/letters such as "Users/John/Desktop/Projects/") to your current working directory. You might want to create a new folder on your computer for each new project, and then copy the path to this folder or directory. After you've copied the directory path, let R know you want this to be your working directory by using the `setwd()` function (setwd: "set working directory"). The path to my directory is "/Users/Hause/Dropbox/Working Projects/RDataScience/R Basics/".

setwd("/Users/Hause/Dropbox/Working Projects/RDataScience/R Basics/")

#' To get R to print your current working directory, use `getwd()`

getwd()

#' Installing packages/libraries


#' # Reading files into R
#' 



#### load packages ####

library(tidyverse); library(data.table);library(broom); library(dtplyr); library(cowplot); library(lme4); library(lmerTest); library(ggbeeswarm)

#' # Section 2
c(1, 2, 3)

#' A script comment that includes **markdown** formatting.


ggplot(mtcars, aes(cyl, mpg)) +
    geom_point()




# rmarkdown::render("MyRScript.R", "github_document")