### Open Data Analysis Project in R
### Making descriptive analysis and plots
### by Nicole Riatto Victor
### Based on article: "Trophic allometry in a predator that carries corpses of its prey"
    # DOI: 10.1111/btp.13148
    # Journal: Biotropica
    # by Victor & Costa-Pereira (2022)

# Packages required ------------------------------------------------------------
library(tidyverse)
library(ggdist)
library(cowplot)
library(patchwork)

# Input data -------------------------------------------------------------------
data <- read.csv("data/processed/data-assassin-bugs", h = T, sep = ",", dec = ".")

# Descriptive analysis ---------------------------------------------------------
summary(data$num_ants)
sd(data$num_ants, na.rm = T)

summary(data$ppsr)
sd(data$ppsr)

# Plot the data ----------------------------------------------------------------
## I will create two raincloud plots: one for the number of ants and the other for the ppsr
## This plot describes the distribution of the data - it has a boxplot and a histogram

### Number of ants plot
num_ants_plot <- ggplot(data, aes(x = NA, y = num_ants)) +
  theme_classic() +
  ggdist::stat_halfeye(
    adjust = .5,
    width = .6,
    ## set slab interval to show IQR and 95% data range
    .width = c(.5, .95), fill = alpha("cornflowerblue", 0.5)
  ) +
  ggdist::stat_dots(
    side = "left",
    dotsize = 7.5,
    justification = 1.15,
    binwidth = .3
  ) +
  labs(y = "Number of prey") +
  coord_cartesian(xlim = c(1.2, NA)) +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

num_ants_plot

### PPSR plot
ppsr_plot <- ggplot(data, aes(x=NA, y = ppsr)) +
  theme_classic() +
  ggdist::stat_halfeye(
    adjust = .5,
    width = .6,
    ## set slab interval to show IQR and 95% data range
    .width = c(.5, .95), fill = alpha("cornflowerblue", 0.5)
  ) +
  ggdist::stat_dots(
    side = "left",
    dotsize = 0.5,
    justification = 1.15,
    binwidth = .3
  ) +
  coord_cartesian(xlim = c(1.2, NA)) +
  labs(y= "PPSR", x = "") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

ppsr_plot

# Combining both plots ---------------------------------------------------------
final_plot <- ppsr_plot + num_ants_plot
final_plot
