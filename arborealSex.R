library(ArctosR)
library(tidyverse)
library(dplyr)
result_params <- get_result_parameters()
MVZ_male_arboreal<-get_records(guid_prefix="MVZ:Herp", scientific_name="Aneides lugubris", sex="male",
                          columns=list("guid", "sex"),all_records = TRUE)
x<-response_data(MVZ_male_arboreal)
head(x)

tail(x)