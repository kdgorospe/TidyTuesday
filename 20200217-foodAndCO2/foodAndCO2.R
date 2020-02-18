
rm(list=ls())
library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)
library(gridExtra)

# Get the Data

food_consumption <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-02-18/food_consumption.csv')

# Get worldmap from rnaturalearthdata
worldmap <- ne_countries(scale = "medium", returnclass = "sf")

# CLEAN NAMES:
# Which names don't match
food_countries<-unique(food_consumption$country)
food_countries[!food_countries %in% worldmap$name]

# Name in food_consumption data
#[1] "USA"                    "Hong Kong SAR. China"   "French Polynesia"      
#[4] "Czech Republic"         "Bosnia and Herzegovina" "South Korea"           
#[7] "Taiwan. ROC"     

# Name in worldmap data
# Fr. Polynesia
# Korea
# Czech Rep.
# Taiwan
# Hong Kong
# United States
# Bosnia and Herz.

# Change names in Food Consumption Data
food_consumption<-food_consumption %>%
  mutate(country = recode(country,
                          "USA"="United States",
                          "Hong Kong SAR. China"="Hong Kong",
                          "French Polynesia"="Fr. Polynesia",
                          "Czech Republic"="Czech Rep.",
                          "Bosnia and Herzegovina"="Bosnia and Herz",
                          "South Korea"="Korea",
                          "Taiwan. ROC"="Taiwan"))

# Join map and food consumption data
worldmap<-worldmap %>%
  right_join(food_consumption, by=c("name_long"="country"))



### BUBBLE PLOT MAP OF TOTAL CO2 EMMISSIONS
world_co2<-worldmap %>%
  group_by(name_long) %>%
  summarise(total_co2=sum(co2_emmission), na.rm=TRUE)

world_co2<-cbind(world_co2, st_coordinates(st_centroid(world_co2)))

allplots<-
  theme_void()+
  theme(axis.text.x = element_blank(),
        legend.title=element_text(size=30), 
        legend.text=element_text(size=25),
        title = element_text(size=40))

p1<-ggplot()+
  geom_sf(data=world_co2, fill="green")+
  geom_point(data=world_co2, aes(X, Y, size=total_co2), alpha=0.5)+
  scale_size(limits=c(1,2200), range=c(1,30), name="CO2 emmissions\n(kg/person/year)")+
  labs(title="CO2 Emissions with All Food Consumption")+
  allplots

png(filename="All CO2.png", width=1800, height=1200)
print(p1)
dev.off()


# BUBBLE PLOT MAP OF CO2 EMISSIONS WITH NO BEEF
world_co2_nobeef<-worldmap %>%
  filter(food_category!="Beef")%>%
  group_by(name_long) %>%
  summarise(total_co2=sum(co2_emmission), na.rm=TRUE)

world_co2_nobeef<-cbind(world_co2_nobeef, st_coordinates(st_centroid(world_co2_nobeef)))

p2<-ggplot()+
  geom_sf(data=world_co2_nobeef, fill="green")+
  geom_point(data=world_co2_nobeef, aes(X, Y, size=total_co2), alpha=0.6)+
  scale_size(limits=c(1,2200), range=c(1,30), name="CO2 emmissions\n(kg/person/year)")+
  labs(title="CO2 Emissions Minus Beef Consumption")+
  allplots

png(filename="No Beef CO2.png", width=1800, height=1200)
print(p2)
dev.off()

png(filename="foodAndCO2-TidyTuesdayPlot.png", width=1800, height=1200)
grid.arrange(p1, p2, nrow = 2)
dev.off()

               