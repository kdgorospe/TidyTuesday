

##CREATE ANIMATION OF DOTS MOVING AFTER REMOVING BEEF
# TOTAL
food_consumption %>% 
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent)) +
  xlim(0,700) +
  ylim(0,2250)

## AFTER REMOVING BEEF
food_consumption %>% 
  filter(food_category!="Beef") %>%
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent))+
  xlim(0,700) +
  ylim(0,2250)


## CREATE ANIMATION OF DOTS MOVING AFTER REMOVING FISH
# TOTAL
food_consumption %>% 
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent)) +
  xlim(0,700) +
  ylim(0,2250)


## AFTER REMOVING FISH
food_consumption %>% 
  filter(food_category!="Fish") %>%
  group_by(country) %>%
  summarise(total_co2=sum(co2_emmission), total_consumption=sum(consumption), continent=first(continent)) %>%
  ggplot() +
  geom_point(aes(x=total_consumption, y=total_co2, colour=continent))+
  xlim(0,700) +
  ylim(0,2250)


