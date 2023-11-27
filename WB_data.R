library(tidyverse)
library(wbstats)
#import WB datasets-----
##GDP----
GDP <- wb_data(indicator = "SI.POV.DDAY",
               country = "countries_only",
               start_date = 2000,
               end_date = 2022)

##access to basic water----
WATER <- wb_data(indicator = "SH.H2O.BASW.ZS",
                 country = "countries_only",
                 start_date = 2000,
                 end_date = 2022)

##country list for income status----
countries <- wb_countries()

#filter GDP and water for only LIC and only 2000 & 2022
GDP_LIC <- GDP |> left_join(countries |> 
                              select(iso3c, income_level_iso3c), join_by(iso3c)) |> 
  filter(income_level_iso3c =="LIC",
         date %in% c(2000,2022))


WATER_LIC <- WATER |> left_join(countries |> 
                                         select(iso3c, income_level_iso3c), join_by(iso3c)) |> 
  filter(income_level_iso3c =="LIC",
         date %in% c(2000,2022))
