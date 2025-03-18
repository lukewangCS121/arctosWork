library(ArctosR)
library(ggplot2)
library(sf)
library(maps)
library(dplyr)
result_params <- get_result_parameters()
CAGold<-get_records(guid_prefix="MVZ:Bird", scientific_name="Aquila chrysaetos", state_prov="California",
                               columns=list("guid", "dec_lat", "dec_long"),all_records = TRUE)
goldDF<-response_data(CAGold)
goldNADF<-goldDF|>
  filter(!is.na(dec_lat)&!is.na(dec_long)&dec_lat!=""&dec_long!="")|>
  mutate(dec_lat = as.numeric(dec_lat), dec_long = as.numeric(dec_long))

CA_map <- map_data("state") |> 
  filter(region == "california")
ggplot() +
  geom_polygon(data = CA_map, aes(x = long, y = lat, group = group)) +
  geom_point(data = goldNADF, aes(x = dec_long, y = dec_lat), 
             color = "red", size = 2, alpha = 0.7)
  theme_minimal()