# Script para Liininha
# Stenio Foerster
# 09 MAY 2022

library(tidyverse)

setwd('~/Nextcloud/Liina/')

tw <- read.csv('table_wide.csv')

head(tw)

dim(tw)

tl <- read.csv('table_long.csv')

dim(tl)

length(tl$KaemusParticipant) # how many ids in the long table?

length(unique(tl$KaemusParticipant)) # how many unique ids in the long table?

length(tw$KaemusParticipant) # how many ids in the wide table?

length(unique(tw$KaemusParticipant)) # how many unique ids in the wide table?

setdiff(x = tw$KaemusParticipant, y = tl$KaemusParticipant) # what are the ids that are present in the wide table but not in the long table?

length(setdiff(x = tw$KaemusParticipant, y = tl$KaemusParticipant)) # how many ids are present in the wide table but not in the long table?

ft <- tw[tw$KaemusParticipant %in% unique(tl$KaemusParticipant), ] # filter rows in the wide table according to unique ids in the long table

rownames(ft) <- NULL # just to keep the table more organised

head(ft)

tail(ft)

dim(ft) # 223 rows, seems ok



















