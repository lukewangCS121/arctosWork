library(ArctosR)
library(ggplot2)
library(sf)
library(maps)
library(dplyr)
library(geodata)
library(terra)
result_params <- get_result_parameters()
CAGold<-get_records(guid_prefix="MVZ:Bird", scientific_name="Aquila chrysaetos", state_prov="California", #include more/all collections
                               columns=list("guid", "dec_lat", "dec_long"),all_records = TRUE)
#other attributes i.e parts(like skull, check record search table), snout-vent length(min max median of each species), weight,
goldDF<-response_data(CAGold)
goldNADF<-goldDF|>
  filter(!is.na(dec_lat)&!is.na(dec_long)&dec_lat!=""&dec_long!="")|>
  mutate(dec_lat = as.numeric(dec_lat), dec_long = as.numeric(dec_long))#set golden eagle coordinates into a DF, set latitude and longitude into numerical

bio_climate <- worldclim_global(var = "bio", res = 5, path = "climate_data") #download bioclimatic variables, resolution in 5 arc-minutes, folder @climate_data
points_vect <- vect(goldNADF, geom = c("dec_long", "dec_lat"), crs = "EPSG:4326")#vect() turns DF into spatial vector using longitude and latitude
bio1_vals <- extract(bio_climate[[1]], points_vect)#take coordinate points and look up values of each bioclimatic variable
clim_values <- extract(bio_climate, points_vect)
clim_values |> names()
gold_temp <- bind_cols(goldNADF, clim_values |> select(wc2.1_5m_bio_1))#selects only first column, bind with original data
gold_temp <- gold_temp |> 
  rename(annual_mean_temp = wc2.1_5m_bio_1)
head(gold_temp)
summary_gold <- gold_temp |> 
  summarise(
    count = n(),
    mean_temp = mean(annual_mean_temp, na.rm = TRUE) ,
    min_temp = min(annual_mean_temp, na.rm = TRUE),
    max_temp = max(annual_mean_temp, na.rm = TRUE),
    median_temp = median(annual_mean_temp, na.rm = TRUE)
  )
summary_gold

#Mapping, will use later
# CA_map <- map_data("state") |> 
#   filter(region == "california")
# ggplot() +
#   geom_polygon(data = CA_map, aes(x = long, y = lat, group = group)) +
#   geom_point(data = goldNADF, aes(x = dec_long, y = dec_lat), 
#              color = "red", size = 1, alpha = 0.7)
#   theme_minimal()

  
  #climate data(geodata package, pick lower resolution first for testing), trait work
  #table + map, climate as base map, extract all values at each point of given parameter, 
  #table of max/min/median summary stats. 
  #merging on top of the map
  