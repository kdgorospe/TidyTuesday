library(tidyverse)
library(countrycode)

# Get the Data

food_consumption <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')

food_consumption$continent <- countrycode(sourcevar = food_consumption[["country"]],
                            origin = "country.name",
                            destination = "continent")

## CONSIDER SEPARATING OUT AMERICAS into North, South, Caribbean?

food_consumption %>% 
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent)) +
  xlim(0,700) +
  ylim(0,2250)

## CREATE ANIMATION OF DOTS MOVING AFTER REMOVING BEEF (where do different continents go)
food_consumption %>% 
  filter(food_category!="Beef") %>%
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent))+
  xlim(0,700) +
  ylim(0,2250)

## CREATE BUBBLE PLOT MAP OF DOTS GETTING SMALLER AFTER REMOVING BEEF






## CREATE ANIMATION OF DOTS MOVING AFTER REMOVING FISH
food_consumption %>% 
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent)) +
  xlim(0,700) +
  ylim(0,2250)

## OTHER "BIG" reductions from LAMB + GOAT and DAIRY


## CREATE ANIMATION OF DOTS MOVING AFTER REMOVING BEEF (where do different continents go)
food_consumption %>% 
  filter(food_category!="Fish") %>%
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent))+
  xlim(0,700) +
  ylim(0,2250)





               