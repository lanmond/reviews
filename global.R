library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(stringr)
library(janitor)
library(scales)
library(plotly)
library(tidyr)


data <- read.csv('./data_clean.csv', stringsAsFactors = FALSE)