library(readr)
library(tidyverse)
library(readxl)
setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus data wide to long")

dw <- read_excel("output/EMO-145_background-in-Hans-analyses-22-05-09-wide.xlsx")
dl <- read_csv("kaemus data wide to long/output/EMO-valideerimisuuring-1-4-5-Hans-22-04-22-long.csv")

length(dl$KaemusParticipant) # how many ids in the long table?
length(unique(dl$KaemusParticipant)) # how many unique ids in the long table?
length(dw$KaemusParticipant) # how many ids in the wide table?
length(unique(dw$KaemusParticipant)) # how many unique ids in the wide table?

setdiff(x = dw$KaemusParticipant, y = dl$KaemusParticipant) # what are the ids that are present in the wide table but not in the long table?

length(setdiff(x = dw$KaemusParticipant, y = dl$KaemusParticipant)) # how many ids are present in the wide table but not in the long table?

ft <- dw[dw$KaemusParticipant %in% unique(dl$KaemusParticipant), ] # filter rows in the wide table according to unique ids in the long table

dws = dw %>% select(KaemusParticipant, Sugu, Vanus, Haridus, Emakeel, Eriala)

emoraw_column <- merge(dl, dws, by = "KaemusParticipant") #EMO1

write.csv(emoraw_column, "EMO-145_long-sex-age-occupation.csv")

