library(ArctosR)
library(tidyverse)
library(dplyr)
result_params <- get_result_parameters()
MVZ_Sulawesi<-
  get_records(state_prov="Sulawesi", guid_prefix="MVZ:Mamm", 
              columns=list("guid", "species"),all_records = TRUE) #get all specimen from Sulawesi
SulaDF<-response_data(MVZ_Sulawesi) #form into dataframe
head(SulaDF)
uniqueSpeciesSula<-distinct(SulaDF, species) #get all unique species
ggplot(data=SulaDF, aes(x=factor(species)))+
  geom_bar()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+#adjust angle of x axis label
  labs(x="Species Name")

#add frequency into a barchart

