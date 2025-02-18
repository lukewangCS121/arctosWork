library(ArctosR)
library(tidyverse)

# Request a list of all result parameters. These are the names that can show up
# as columns in a dataframe returned by ArctosR.
result_params <- get_result_parameters()

# Print the first six rows and first 3 columns to the console.
result_params[1:6, 1:3]
#>                     display            obj_name query_cost
#> 1 GUID (DarwinCore Triplet)                guid          1
#> 2    Catalog Number Integer    catalognumberint          1
#> 3               Identifiers         identifiers          1
#> 4        Simple Identifiers othercatalognumbers          1
#> 5                 Accession         accn_number          1
#> 6                     Media               media          1

# If using RStudio, view the entire dataframe of result parameters.
View(result_params)

count <- get_record_count(
  scientific_name = "Canis lupus", guid_prefix = "MSB:Mamm"
)
response <- get_records(
  scientific_name = "Canis lupus", guid_prefix = "MSB:Mamm",
  columns = list("guid", "parts", "partdetail")
)
response
