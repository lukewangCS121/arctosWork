library(ArctosR)
library(tidyverse)
library(dplyr)
result_params <- get_result_parameters()
mvz_bat<-
  get_records(guid_prefix="MVZ:Mamm", scientific_name="Myotis",
              columns=list("guid","weight","total_length"),all_records = TRUE)#wingspan?
batDF<-response_data(mvz_bat)
batDF<-batDF|>
  filter(weight!=""&total_length!="")
head(batDF)
ggplot(data=batDF,mapping=aes(x=total_length, y=weight))+
  geom_point()

