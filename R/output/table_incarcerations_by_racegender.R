# Builds a LaTeX table of mean arrests by race and gender.
# See the pivoting vignette for how to use pivot functions.
# vignette("pivot")
# Documentation for the kableExtra package is here:
# https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_pdf.pdf
install.packages(c("readr","here","tidyverse","ggplot2","ggthemes","stargazer","knitr","kableExtra","stringr"))
library(tidyverse)
library(readr)
library(here)
library(ggplot2)
library(ggthemes)
library(stargazer)
library(knitr)
library(kableExtra)
library(stringr)
library(snakecase)
read_csv(here("data/Incarceration_Data_Clean.csv")) %>%
  
  # summarize arrests by race and gender
  group_by(race, gender) %>%
  summarize(total_incarcerations = mean(total_incarcerations)) %>%
  
  # pivot the values from race into columns
  pivot_wider(names_from = race, values_from = total_incarcerations) %>%
  
  # rename columns using snakecase
  rename_with(to_title_case) %>%
  
  # create the kable object. Requires booktabs and float LaTeX packages
  kbl(
    caption = "Mean incarcerations in 2002 by Race and Gender",
    booktabs = TRUE,
    format = "latex",
    label = "tab:summarystats"
  ) %>%
  kable_styling(latex_options = c("striped", "HOLD_position")) %>%
  
  write_lines(here("tables/incarcerations_by_racegender.tex"))
  