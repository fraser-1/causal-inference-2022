# Builds a bar graph with total arrests on the y axis and race/gender on the
# x axis. Refer to my presentation on graphing for more detail.
install.packages(c("readr","here","tidyverse", "ggplot2","ggthemes"))
library(tidyverse)
library(readr)
library(here)
library(ggplot2)
library(ggthemes)
data = read_csv(here("data/Incarceration_Data_Clean.csv")) %>%
  group_by(race, gender) %>%
  summarize(total_incarcerations = mean(total_incarcerations)) %>%
  ggplot(aes(race, total_incarcerations, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
    labs(
      x = "Race", 
      y = "Mean Incarcerations", 
      fill = "Gender",
      title = "Mean Number of Incarcerations in 2002 by Race and Gender") +
    #theme_minimal() +
    scale_fill_economist()

ggsave(here("figures/incarceration_by_racegender.png"), width=8, height=4.5)