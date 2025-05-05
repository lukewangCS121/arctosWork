library(ArctosR)
library(tidyverse)
library(dplyr)
result_params <- get_result_parameters()
MVZ_Scel<-
  get_records(guid_prefix="MVZ:Herp", scientific_name="Sceloporus", detected="snout-vent length",
              columns=list("guid"),all_records = TRUE)
ScelDF<-response_data(MVZ_Scel)
head(ScelDF)
#Get JSON table

