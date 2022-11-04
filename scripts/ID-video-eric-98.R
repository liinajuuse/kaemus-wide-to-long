library(tidyverse)
library(readxl)
EMO2021_1_48 <- read_excel("C:/Users/liina/Desktop/EMO2021-1-48.xlsx",col_names=F)

library(readr)
EMO2021_VideoID_KaemuseID_1_clean <- read_csv("C:/Users/liina/Desktop/EMO2021-VideoID-KaemuseID-1-clean.csv")

emoraw_test = EMO2021_1_48
test5 = EMO2021_VideoID_KaemuseID_1_clean

emoraw_column <- data.frame()

#emoraw_test <- emoraw[5663:5760]
COLUMSREPEAT <- 48
COLUMSSHIFT <- 1
i <-0
#while((i+1)*COLUMSREPEAT+COLUMSSHIFT <= ncol(emoraw_test))
while(i < 98)
{
  ID <- emoraw_test[1,i*COLUMSREPEAT+COLUMSSHIFT]
  #print(ID)
  ID <- scan(text=as.character(ID), what=" ")[3]
  #print(ID)
  ID <- substr(ID,1,nchar(ID)-1)
  #print(ID)
  emoraw_test[2:nrow(emoraw_test),i*COLUMSREPEAT+COLUMSSHIFT] <- ID
  print(ID)
  
  
  sub_emoraw <- emoraw_test[3:nrow(emoraw_test),(i*COLUMSREPEAT+COLUMSSHIFT):((i+1)*COLUMSREPEAT+COLUMSSHIFT-1)]
  names(sub_emoraw) <- NULL
  names(sub_emoraw) <- names( emoraw_test[2:nrow(emoraw_test),(1*COLUMSREPEAT+COLUMSSHIFT):((1+1)*COLUMSREPEAT+COLUMSSHIFT-1)])
  sub_emoraw$KaemusParticipant = paste0(1:nrow(sub_emoraw), "_001") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  emoraw_column<- rbind(emoraw_column,sub_emoraw)
  i <- i+1
  print(i)
}  


emoraw_column <- merge(emoraw_column, test5, by.x = "...49", by.y ="KaemusID")
emo_delete = emoraw_column[c(1,2,10,16,23,28,35,40,46,49,50)]
names(emo_delete) = c("KaemusID", "KaemusJrk", "Valence", "Arousal", "Emotion1", "Intensity1", "Emotion2", "Intensity2", "Natural", "KaemusParticipant", "VideoID")

#add emotion and condition based on VideoID
emo_delete = emo_delete %>%
  mutate(Emotion = str_sub(VideoID, -4)) %>% 
  mutate(Emotion = substr(Emotion, 3, 3)) %>%
  mutate(Emotion = recode(Emotion, "6" = "Neutraalne", "1" = "Vastikus", "2" = "Üllatus", "3" = "Kurbus", "4" = "Viha",
                            "5" = "Hirm", "7" = "Rõõm")) %>% 
  mutate(Condition = sapply(strsplit(t$VideoID, split="_"), "[", 4)) %>% 
  mutate(Condition = as.numeric(Condition)) %>% 
  mutate(Condition = ifelse(Condition < 16, "Ekman", "Under"))


#see osa vajab veel putitamist
#kuidas nüüd ei-d jah-id saada?
#uus fail, teised columnrepeatid?
kastunned <- read_excel("C:/Users/liina/Desktop/kastunned.xlsx", col_names = T)
kastunned_test = kastunned
kastunned_column <- data.frame()

COLUMSREPEAT <- 18
COLUMSSHIFT <- 1
i <-0
#while((i+1)*COLUMSREPEAT+COLUMSSHIFT <= ncol(emoraw_test))
while(i < 2)
{
  ID <- kastunned_test[1,i*COLUMSREPEAT+COLUMSSHIFT]
  #print(ID)
  ID <- scan(text=as.character(ID), what=" ")[3]
  #print(ID)
  ID <- substr(ID,1,nchar(ID)-1)
  #print(ID)
  kastunned_test[2:nrow(kastunned_test),i*COLUMSREPEAT+COLUMSSHIFT] <- ID
  print(ID)
  
  
  sub_kastunned <- kastunned_test[3:nrow(kastunned_test),(i*COLUMSREPEAT+COLUMSSHIFT):((i+1)*COLUMSREPEAT+COLUMSSHIFT-1)]
#  print(sub_kastunned)
  names(sub_kastunned) <- NULL
  names(sub_kastunned) <- names(kastunned_test[2:nrow(kastunned_test),(1*COLUMSREPEAT+COLUMSSHIFT):((1+1)*COLUMSREPEAT+COLUMSSHIFT-1)])
  sub_kastunned$KaemusParticipant = paste0(1:nrow(sub_kastunned), "_001") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  kastunned_column<- rbind(kastunned_column,sub_kastunned)
  i <- i+1
  print(i)
}  

kastunned_delete = kastunned_column[c(1,11,17,19)]
names(kastunned_delete) = c("KaemusID", "Know", "Seen", "KaemusParticipant")

emo_merge = merge(emo_delete, kastunned_delete, by = c("KaemusParticipant")
