library(tidyverse)
library(tsibble)

# Load data
bookings <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-11/hotels.csv')

# What proportion canceled (is_canceled = 1)
sum(bookings$is_canceled) / dim(bookings)[1]

# Look at categorical variables next...
bookings_cats<-bookings %>%
  mutate_if(sapply(bookings, is.character), as.factor)

summary(bookings)

# Look at continuous variables first
bookings_nums<-bookings %>%
  select_if(is.numeric) %>%
  mutate_all(~scales::rescale(., c(0,1)))

### How to make strip plot???
explore_nums<-ggplot()+
  geom_point(bookings_nums,aes(x=names(bookings_nums, y=)))


