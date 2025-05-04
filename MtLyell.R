library(ArctosR)
library(tidyverse)
library(ggplot2)
result_params <- get_result_parameters()
MVZ_sorex<-
  get_records(scientific_name="Sorex lyelli", guid_prefix="MVZ:Mamm", 
              columns=list("guid", "year_collected"),all_records = TRUE)
SorexDF<-response_data(MVZ_sorex)
ggplot(data=SorexDF, aes(x=factor(year_collected)))+
  xlab("Year Collected")+
  ylab("Count")+
  geom_bar()#bar_chart

