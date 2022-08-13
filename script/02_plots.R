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
data <- read.csv("data/raw/data_assassin_bugs.csv", h = T, sep = ";", dec = ",")

# Figure 2a ----------
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

# Figure 2b ----------
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

# Figure 2c ----------
model_plot <- ggplot(data, aes(x=ppsr, y = num_ants)) +
  theme_classic() +
  geom_point(size=2.5) +
  labs(x= "PPSR", y = "Number of prey") +
  geom_smooth(method="glm", method.args = list (family = "poisson"),
              color="coral")

dev.off()

# Creating Figure 2 ----------
patchwork <- ppsr_plot+num_ants_plot | model_plot
patchwork + plot_annotation(tag_levels = 'a') &  theme(plot.tag = element_text(size = 10))

# Generalized Linear Model ----------
model_assassin_bugs <- glm(round(data$num_ants) ~ data$ppsr, family = poisson)
summary(model_assassin_bugs)
exp(coef(model_assassin_bugs))