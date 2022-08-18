### Open Data Analysis Project in R
### Fitting a Generalized Linear Model
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

# Data plot --------------------------------------------------------------------
## I will plot the data in a graph just to see how the points are distributed
ggplot(data, aes(x = ppsr, y = num_ants)) +
  theme_classic() +
  geom_point(size = 2.5) +
  labs(x = "PPSR", y = "Number of prey")

## Giving the nature of the data, I chose the Generalized Linear Model with Poisson distribution to fit it
### Predictor variable: PPSR
### Response variable: number of prey (discrete)
model_plot <- ggplot(data, aes(x = ppsr, y = num_ants)) +
  theme_classic() +
  geom_point(size = 2.5) +
  labs(x = "PPSR", y = "Number of prey") +
  geom_smooth(method = "glm", method.args = list (family = "poisson"),
              color = "coral")

model_plot

# Discussing about the Generalized Linear Model --------------------------------
model_assassin_bugs <- glm(data$num_ants ~ data$ppsr, family = poisson(link = "log"))
summary(model_assassin_bugs)

# Creating the final figure ----------------------------------------------------
## I will combine the two figures that I did in script "02_plots.R" with the model 
source("scripts/02_plots.R")
figure <- ppsr_plot + num_ants_plot | model_plot
figure_final <- figure + plot_annotation(tag_levels = 'a') &  theme(plot.tag = element_text(size = 10))
figure_final
dev.off()

# Saving the final figure
pdf("outputs/figs/figure_plots.pdf", width = 10, height = 5)
figure_final
dev.off()
