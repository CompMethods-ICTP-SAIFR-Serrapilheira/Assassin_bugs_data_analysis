### Data analysis in R enviroment
### Article: "Trophic allometry in a predator that carries corpses of its prey"
### DOI: 10.1111/btp.13148
### Journal: Biotropica
### by Victor & Costa-Pereira (2022)

# Packages required ----------
library(tidyverse)
library(ggdist)
library(cowplot)
library(patchwork)

# Input data ----------
data <- read.csv("data/data_assassin_bugs.csv", h = T, sep = ";", dec = ",")