library(tidyverse)
library(readr)
ICPMS_imported <- read.csv("ICPMS_Data.csv", 
                           skip = 1, 
                           na = "N/A")
sample_key <- read.csv("Sample_Key.csv", 
                       skip = 0)

RSD_data <- ICPMS_imported %>%
  select(Cr52 = CPS.RSD,
         Cr53 = CPS.RSD.1,
         As75 = CPS.RSD.2,
         Cd111 = CPS.RSD.3,
         Cd114 = CPS.RSD.4,
         Pb208 = CPS.RSD.5,
         Ge_RSD = CPS.RSD.7,
         Sample.Key) %>%
  pivot_longer(1:6,
               names_to = "metal",
               values_to = "RSD")

ICPMS_tidy <- ICPMS_imported %>%
  select(Cr52 = CPS,
         Cr53 = CPS.1,
         As75 = CPS.2,
         Cd111 = CPS.3,
         Cd114 = CPS.4,
         Pb208 = CPS.5,
         Ge72 = CPS.7,
         Sample.Key) %>%
  pivot_longer(1:6,
               names_to = "metal",
               values_to = "CPS")%>%
  mutate(RSD = RSD_data$RSD/RSD_data$Ge_RSD,
         CPS=CPS/Ge72)%>%
  select(-Ge72)

ICPMS_merged <- merge(ICPMS_tidy, sample_key)
ICPMS_merged