library(readr)
library(tidyverse)
library(dplyr)
library(tidyr)
raw_data <- read.csv("C:/Users/Emily's Laptop/Desktop/sta304-w22-paper4/sta304-w22-paper4/outputs/data/raw_data.csv")

# remove header, footer and unnecessary data
rates_child_mortality <- as.data.frame(raw_data[c(5,6,7),])

colnames(rates_child_mortality)[1] <- "x"

rates_child_mortality <- separate(data = rates_child_mortality, col = x, 
                into = c("x", 
                         "years_preceeding",
                         "neonatal", 
                         "postneonatal", 
                         "infant_mortality", 
                         "child_mortality", 
                         "under_5_mortality"), sep = " +") %>% select(-c(x))
view(rates_child_mortality)

rates_early_child_mortality_long <- rates_child_mortality %>% 
  gather(mortality, nmr, -c(years_preceeding)) %>% 
  mutate(mortality = case_when(
    mortality == "neonatal" ~ "Neonatal",
    mortality == "postneonatal" ~ "Postneonatal",
    mortality == "infant_mortality" ~ "Infant",
    mortality == "child_mortality" ~ "Child",
    mortality == "under_5_mortality"~ "Under-five"))

view(rates_early_child_mortality_long)

write_csv(
  x = rates_early_child_mortality_long, 
  file = "cleaned_data.csv")


# Test the cleaned dataset
rates_early_child_mortality_long$mortality %>%  
  unique() == c("Neonatal", 
                "Postneonatal", 
                "Infant", 
                "Child",
                "Under-five")

rates_early_child_mortality_long$mortality %>%  unique() %>%  length() == 5

rates_early_child_mortality_long$year %>%  min() == 1971

rates_early_child_mortality_long$year %>%  max() == 2020

rates_early_child_mortality_long$nmr %>%  min() >= 0

rates_early_child_mortality_long$nmr %>%  max() <= 1000

rates_early_child_mortality_long$nmr %>%  class() == "numeric"
