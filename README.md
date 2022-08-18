# Assassin_bugs_data_analysis
Author: Nicole Riatto Victor (nriattovictor@gmail.com)
<br>
Project created to the Computational Methods Course under the supervision of Sara Mortara and Andrea Sánchez Tapia
<br>
August, 2022

## Project structure
```
project/
     ├── data/
     │   ├── raw
     │   └── processed
     ├── docs/
     ├── scripts/
     ├── outputs/
     │   └── figs/
     └── README.md
```
`docs` -> you will find the report in PDF and in a LaTeX code, a .bib file with references, and a .csv file with the links for all the photos used in this project.

## Requirements
This project was developed in `R`.
<br>
I used the following packages:
`tidyverse`
`ggdist`
`cowplot`
`patchwork`

## Dataset
The raw data was collected by me with the ImageJ software (https://imagej.nih.gov/ij/).
<br>
`data-ppsr.csv` -> contains the measures of predator and prey sizes in pixels
<br>
`data-ant-gaster.csv` -> contains the measures of the ant's gaster in pixels
<br>
`data-backpack.csv` -> contains the measures of the bug's backpack in pixels

The URLs of each photo sellected by me can be found in `docs/links.csv`.

The Figure 1 in `docs/proj_report.pdf` will not be made available in this repository because it's an original photo from Melvyn Yeo. He authorized the use for education purpose. If you want, check https://flic.kr/ps/2iz6em (very beautiful photos). I thank Melvyn for the permission.

## Instructions
To reproduce this project, follow the scripts in order.
<br>
For more information of theoretical background, methods and discussion, see `docs/proj_report.pdf`. 
