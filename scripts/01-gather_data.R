library(janitor)
library(pdftools)
library(purrr)
library(tidyverse)
library(stringi)


download.file(
  "https://dhsprogram.com/pubs/pdf/FR102/FR102.pdf",
  "1998_Kenya_DHS.pdf",
  mode="wb")

all_content <- pdf_text("1998_Kenya_DHS.pdf")

lines <- stri_split_lines(all_content[[110]])[[1]] 
graph_lines <- lines[43:49]
mortality_data <- as.data.frame(graph_lines)
view(mortality_data)

write_csv(
  x = mortality_data, 
  file = "raw_data.csv")