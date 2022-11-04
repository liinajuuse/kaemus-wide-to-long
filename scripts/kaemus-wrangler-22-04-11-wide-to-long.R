install.packages("data.table")
library(data.table)
library(tidyverse)
DT1 = data.table(A=1:3,B=letters[1:3])
DT2 = data.table(A=4:5,B=letters[4:5])
names(DT2) = c("rand", "ramnd2")
DT3 = data.table(A=6:9,B=letters[6:9])
l = list(DT1,DT2,DT3)
rbindlist(l)

# fill missing columns, and match by col names
DT1 = data.table(A=1:3,B=letters[1:3])
DT2 = data.table(B=letters[4:5],C=factor(1:2))
l = list(DT1,DT2)
rbindlist(l, use.names=TRUE, fill=TRUE)

# generate index column, auto generates indices
rbindlist(l, use.names=TRUE, fill=TRUE, idcol=TRUE)
# let's name the list
setattr(l, 'names', c("a", "b"))
rbindlist(l, use.names=TRUE, fill=TRUE, idcol="ID")

t1 = emotest

k <- 3
nc <- ncol(anscombe)
ans2 = lapply(split(as.list(anscombe), cut(1:nc, k, labels = FALSE)), as.data.table)

l = list(ans2)

test2 = rbind(ans$`1`, ans$`2`, ans$`3`)






#võta ühe videos oleva inimese kaupa

participant = emotest %>% 
  subset(KaemusParticipant)

know = emotest %>% 
  select(KnowPersonally, Know)

emotest = emotest[-c(7:8)]
emotest = emotest[-c(1)]

k = 12
nc = ncol(emotest)
ans2 = lapply(split(as.list(emotest), cut(1:nc, breaks = 12*(1:nc), labels = FALSE)), as.data.table)
#Its normally better to keep them in a list and not put them directly into the global environment. If you want to add names then if L 
#is the result of the lapply then, for example: names(L) <- paste0("DF", seq_along(L))
test2 = rbindlist(ans2)
names(test2) = c("VideoID", "KaemusID", "Emotion", "Condition", "KaemusJrk", "Valence", "Intensity", "Emotion1", "HowMuch1", "Emotion2", "HowMuch2", "Natural")

test3 = cbind(participant, know, test2)


#uus suure failiga katsetus
participant = katse$KaemusParticipant
#see on listina, proovin igaks juhuks eraldi data frame'iga ka
participant2 = katse %>% 
  select(KaemusParticipant)

know = katse %>% 
  select(`44591 Kas tunned seda inimest isiklikult?`, `44591 Kas tead või oled seda inimest näinud, kuid ei tunne teda isiklikult?`)

katse3 = katse2[1:168]

nc = ncol(katse3)
ans2 = lapply(split(as.list(katse3), cut(1:nc, breaks = 12*(1:nc), labels = FALSE)), as.data.table)
#Its normally better to keep them in a list and not put them directly into the global environment. If you want to add names then if L 
#is the result of the lapply then, for example: names(L) <- paste0("DF", seq_along(L))
test2 = rbindlist(ans2, use.names = F)
test3 = cbind(participant, know, test2)
names(test3) = c("KaemusParticipant", "KnowPersonally", "Know", "VideoID", "KaemusID", "Emotion", "Condition", "KaemusJrk", "Valence", "Arousal", "Emotion1", "Intensity1", "Emotion2", "Intensity2", "Natural")

