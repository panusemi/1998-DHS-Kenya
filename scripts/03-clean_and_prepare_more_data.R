library(readr)
library(tidyverse)
library(dplyr)
library(tidyr)
library(hacksaw)
raw_data <- read.csv("C:/Users/Emily's Laptop/Desktop/sta304-w22-paper4/sta304-w22-paper4/outputs/data/raw_data.csv")

# Data for mothers education 
# go to the page
lines <- stri_split_lines(all_content[[112]])[[1]] 

# remove headers and footer
lines <- lines[27:30]

child_mortality_moth_educ <- as.data.frame(lines)

child_mortality_moth_educ <- child_mortality_moth_educ %>% 
  separate(lines, into = c("x", "y", 
                           "education", 
                           "neonatal", 
                           "postneonatal", 
                           "infant_mortality", 
                           "child_mortality", 
                           "under_5_mortality"), " +")

child_mortality_moth_educ <- child_mortality_moth_educ %>% 
  shift_row_values(.dir="right", at=4) %>% select(-c(x,y))

child_mortality_moth_educ$education <- c("No education", 
                                         "Primary incomplete", 
                                         "Primary complete", 
                                         "Secondary+")
view(child_mortality_moth_educ)

write_csv(
  x = child_mortality_moth_educ, 
  file = "child_mortality_moth_educ_data.csv")



# Data for gender of child 
# go to the page
lines <- stri_split_lines(all_content[[114]])[[1]] 

# remove headers and footer
lines <- lines[12:13]

child_mortality_gender<- as.data.frame(lines)

child_mortality_gender <- child_mortality_gender %>% 
  separate(lines, into = c("x","sex_of_baby", 
                           "neonatal", 
                           "postneonatal", 
                           "infant_mortality", 
                           "child_mortality", 
                           "under_5_mortality"), " +") %>% select(-c(x))
view(child_mortality_gender)

write_csv(
  x = child_mortality_gender, 
  file = "child_mortality_gender_data.csv")



# Data for mothers age 
# go to the page
lines <- stri_split_lines(all_content[[114]])[[1]] 

# remove headers and footer
lines <- lines[16:19]

child_mortality_moth_age<- as.data.frame(lines)
child_mortality_moth_age <- str_replace_all(child_mortality_moth_age$lines, "\\<", "")
child_mortality_moth_age <- as.data.frame(child_mortality_moth_age)

child_mortality_moth_age <- child_mortality_moth_age %>% 
  separate(child_mortality_moth_age, into = c("x","mother_age", 
                                              "neonatal", 
                                              "postneonatal", 
                                              "infant_mortality",
                                              "child_mortality", 
                                              "under_5_mortality"), " +") %>% 
  select(-c(x))
view(child_mortality_moth_age)

write_csv(
  x = child_mortality_moth_age, 
  file = "child_mortality_moth_age_data.csv")



# Data for child medical care
# go to the page
lines <- stri_split_lines(all_content[[114]])[[1]] 

# remove headers and footer
lines <- lines[33:35]

child_mortality_med_care <- as.data.frame(lines)
child_mortality_med_care <- child_mortality_med_care[-c(2), ]
child_mortality_med_care <- as.data.frame(child_mortality_med_care)

child_mortality_med_care <- child_mortality_med_care %>% 
  separate(child_mortality_med_care, into = c("x", "y", "z","a","b",
                                              "medical_care", "neonatal", 
                                              "postneonatal", 
                                              "infant_mortality", 
                                              "child_mortality", 
                                              "under_5_mortality"), " +") %>% 
  select(-c(x, y, z, a, b))

child_mortality_med_care$medical_care <- c("Received both ANC and DS", 
                                           "Received no ANC or DS or received only ANC or DS")

view(child_mortality_med_care)

write_csv(
  x = child_mortality_med_care, 
  file = "child_mortality_med_care_data.csv")