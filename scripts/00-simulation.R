#### Workspace set-up ####
library(janitor)
library(lubridate)
library(tidyverse)

#### Simulate data ####
set.seed(12345)

number_of_years <- 14

simulated_nmr_data <- 
  tibble(
    mortality = 
      c(
        rep('Neonatal', number_of_years),
        rep('Postneonatal', number_of_years),
        rep('Infant', number_of_years),
        rep('Child', number_of_years),
        rep('Under-five', number_of_years)
      ),
    year = 
      rep(c(1:number_of_years + 1984), 5),
    nmr = 
      runif(n = number_of_years * 5,
            min = 0, 
            max = 1000)
  )

head(simulated_nmr_data)

write_csv(
  x = simulated_nmr_data, 
  file = "simulated_data.csv")

# Tests for simulated data
simulated_nmr_data$mortality %>% 
  unique() == c("Neonatal", 
                "Postneonatal", 
                "Infant", 
                "Child",
                "Under-five")

simulated_nmr_data$mortality %>%  unique() %>%  length() == 5

simulated_nmr_data$year %>%  min() == 1983

simulated_nmr_data$year %>%  max() == 1998

simulated_nmr_data$nmr %>%  min() >= 0

simulated_nmr_data$nmr %>%  max() <= 1000

simulated_nmr_data$nmr %>%  class() == "numeric"
