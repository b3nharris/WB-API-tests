library(tidyverse)
library(wbstats)
#import WB datasets-----
##GDP----
povertyin <- wb_data(indicator = "SI.POV.DDAY",
               country = "countries_only",
               start_date = 2000,
               end_date = 2022)

##access to basic water----
basicwaterin <- wb_data(indicator = "SH.H2O.BASW.ZS",
                 country = "countries_only",
                 start_date = 2000,
                 end_date = 2022)

##country list for income status----
countriesin <- wb_countries()

#filter GDP and water for only LIC and only 2000 & 2022-----
poverty_lic <- povertyin |> left_join(countriesin |> 
                              select(iso3c, income_level_iso3c), join_by(iso3c)) |> 
  filter(income_level_iso3c =="LIC",
         date %in% c(2000,2022))


water_lic <- basicwaterin |> left_join(countriesin |> 
                                         select(iso3c, income_level_iso3c), join_by(iso3c)) |> 
  filter(income_level_iso3c =="LIC",
         date %in% c(2000,2022))

#join tables for plotting-----
poverty_water <- poverty_lic |> left_join(water_lic  |> 
                                        select(iso3c, date, SH.H2O.BASW.ZS), join_by(iso3c, date))
#This fails because countries don't have poverty data for each year - need to impute values?