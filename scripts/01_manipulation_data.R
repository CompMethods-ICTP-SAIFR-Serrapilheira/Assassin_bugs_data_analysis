### Open Data Analysis Project in R
### Manipulating data
### by Nicole Riatto Victor
### Based on article: "Trophic allometry in a predator that carries corpses of its prey"
    # DOI: 10.1111/btp.13148
    # Journal: Biotropica
    # by Victor & Costa-Pereira (2022)

# No package required ----------------------------------------------------------

# Calculating the PPSR ---------------------------------------------------------

## Input data
data_ppsr <- read.csv("data/raw/data-ppsr.csv", h = T, sep = ";", dec = ",")

## The PPSR is the ratio between the predator and prey size
## The predator size is the column bug_length and the prey size is the column ant_head_length
ppsr <- (data_ppsr$bug_length)/(data_ppsr$ant_head_length)

## I will create a new column with the PPSR values for each individual
data_ppsr$ppsr <- ppsr

ppsr 

# Calculating the number of ants in each backpack ------------------------------

## Input data
data_volume_ants <- read.csv("data/raw/data-ant-gaster.csv", h = T, sep = ";", dec = ",")
data_volume_backpack <- read.csv("data/raw/data-backpack.csv", h = T, sep = ";", dec = ",")

## Calculating the ant volume

### First, I will calculate the volume of the gaster of an ant
### To do this, I will apply the volume equation
volume <- function(a, b){
  vol <- pi * (4/3) * (a/2) * (b/2)^2
  return(vol)
}

gaster_volume <- volume(data_volume_ants$gaster_length, data_volume_ants$gaster_width)

### I will add a new column in the data_volume_ants table
data_volume_ants$gaster_volume <- gaster_volume

### According to Tschinkel (2013), the gaster volume represents 57% of the ant volume
### I will apply this percentage and calculate the total volume of the ant
ant_volume <- (data_volume_ants$gaster_volume)/0.57

### The result will be added as a new column in the data_volume_ants table
data_volume_ants$ant_volume <- ant_volume

## Calculating the backpack volume

### I will apply again the volume equation to the backpack dimensions
backpack_volume <- volume(data_volume_backpack$backpack_length, data_volume_backpack$backpack_height)
                          
### According to Donev et al. (2004), only 63,7% of the backpack can be occupied by an ant
occup_backpack_volume <- backpack_volume * (0.637)

### I will add another column with this value
data_volume_backpack$backpack_volume_occup <- occup_backpack_volume

## To finish, I will divide the ant volume by the backpack volume that can be occupied by ants
## The result is the number of ants present in the backpack
num_ants <- data_volume_backpack$backpack_volume_occup/data_volume_ants$ant_volume

## As this is a categorical variable - you cannot have 2,5 ants -, I will round the number of ants
num_ants <- round(num_ants)

## Here, I have to make an important observation. 
### It was visually clear that the assassin bug ID27 had 3 ants in his backpack (not being necessary to do all this calculations)
### I will put the number 3 in the 27th position of the vector

num_ants <- replace(num_ants, 27, 3)

num_ants

# Creating a new dataframe -----------------------------------------------------
ID <- c(1:43)
data_assassin_bugs <- data.frame(ID, num_ants, ppsr)

# This new dataframe will be used on the other scripts
write.csv(x = data_assassin_bugs,
          file = "data/processed/data-assassin-bugs",
          row.names = F)
