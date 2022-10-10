# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load(2022, week = 40)
product_hunt <- tuesdata$product_hunt

library(dplyr)
library(ggplot2)


count_hunters <- product_hunt %>%
                    count(hunter) %>% 
                    mutate(
                      hunter_rank = rank(n, ties.method = 'min')
                    )


full_table <- left_join(product_hunt, count_hunters, by='hunter')



corr_upvotes_hunter_rank <- cor.test(x=full_table$upvotes, y=full_table$hunter_rank, method = 'kendall')

corr_product_hunter_rank <- cor.test(x=full_table$product_ranking, y=full_table$hunter_rank, method = 'kendall')

corr_upvotes_product_rank <- cor.test(x=full_table$product_ranking, y=full_table$upvotes, method = 'kendall')


## marilia
## library("tidyverse")
library("wordcloud2")
library("stringr")

product_hunt <- read.csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-10-04/product_hunt.csv')

str_extract_all(product_hunt$category_tags,  boundary("word")) %>%
  unlist() %>%
  table() %>%
  data.frame() %>%
  wordcloud2(size = 1.6)
  
