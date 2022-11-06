# Directory, libraries, data ----------------------------------
library(tidyverse)

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/data/2022")

df <- read_delim("EMO2018 tagasisideuuring2 - EMO2018 tagasisideuuring2.csv", 
                 delim = ";", escape_double = FALSE, trim_ws = TRUE, col_names = FALSE)

#df$id = rep(1:140)

df1 = df[,40:1875]

# Ericu loop, võtab esimesest reast ID, pasteerib selle ridadeks, lisab columnid
emoraw_test = df1
emoraw_column <- data.frame()

COLUMSREPEAT <- 6
COLUMSSHIFT <- 1
i <-0
#while((i+1)*COLUMSREPEAT+COLUMSSHIFT <= ncol(emoraw_test))
while(i < 306)
{
  ID <- emoraw_test[1,i*COLUMSREPEAT+COLUMSSHIFT]
  #print(ID)
  ID <- scan(text=as.character(ID), what=" ")[10]
  #print(ID)
  ID <- substr(ID,1,nchar(ID)-1)
  #print(ID)
  emoraw_test[2:nrow(emoraw_test),i*COLUMSREPEAT+COLUMSSHIFT] <- ID
  print(ID)
  
  
  sub_emoraw <- emoraw_test[3:nrow(emoraw_test),(i*COLUMSREPEAT+COLUMSSHIFT):((i+1)*COLUMSREPEAT+COLUMSSHIFT-1)]
  names(sub_emoraw) <- NULL
  names(sub_emoraw) <- names( emoraw_test[2:nrow(emoraw_test),(1*COLUMSREPEAT+COLUMSSHIFT):((1+1)*COLUMSREPEAT+COLUMSSHIFT-1)])
#  sub_emoraw$KaemusParticipant = paste0(001:nrow(sub_emoraw), "_005") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  emoraw_column <- rbind(emoraw_column,sub_emoraw)
  i <- i+1
  print(i)
}  

t = emoraw_column[c(1,5)]
names(t) = c('KaemusID', 'Emotsioon')

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/data/2022")
VideoID <- read_csv("VideoID.csv")

t = merge(t, VideoID, by = "KaemusID")

#add emotion and condition based on VideoID
emo_delete = emo_delete %>%
  mutate(EmotionID = str_sub(VideoID, -4)) %>% 
  mutate(EmotionID = substr(EmotionID, 3, 3)) %>%
  mutate(EmotionID = recode(EmotionID, "6" = "Neutraalne", "1" = "Vastikus", "2" = "Üllatus", "3" = "Kurbus", "4" = "Viha",
                            "5" = "Hirm", "7" = "Rõõm")) %>% 
  mutate(Condition = sapply(strsplit(VideoID, split="_"), "[", 4)) %>% 
  mutate(Condition = as.numeric(Condition)) %>% 
  mutate(Condition = ifelse(Condition < 16, "Ekman", "Under"))

t = t %>% 
  mutate(EmotionID = str_sub(VideoID, -8, -5)) %>% 
  mutate(EmotionID = substr(EmotionID, 3, 3)) %>% 
  mutate(EmotionID = recode(EmotionID, "6" = "Neutraalne", "1" = "Vastikus", "2" = "Üllatus", "3" = "Kurbus", "4" = "Viha",
                            "5" = "Hirm", "7" = "Rõõm")) %>% 
  mutate(Condition = sapply(strsplit(VideoID, split="_"), "[", 5)) %>% 
  mutate(Condition = as.numeric(Condition)) %>% 
  mutate(Condition = ifelse(Condition < 16, "Ekman", "Under")) %>% 
  mutate(ParticipantID = sapply(strsplit(VideoID, split = "_"), "[", 3))

t = t %>% drop_na(Emotsioon)

# Vastikuse subgrupp
vas = t %>% 
  filter(EmotionID == 'Vastikus')

write_csv(t, 't.csv')

## 05.11.2022 -----------------------------------------------------
# recoding real hits and misses with 1 and 0
vas = vas %>% mutate(Vastikus_A_RC = ifelse(Emotsioon == 'Vastikus', 1, 0))

# dummy grouping variable
vas$group = rep(1:2, len = nrow(vas))

write_csv(vas, 'vas.csv')

t$hit = ifelse(t$Emotsioon == t$EmotionID, 1, 0)

colnames(t) = c('KaemusID', 'Emotion_A', 'VideoID', 'Emotion_T', 'Condition', 'StimulusID', 'Hit')

write_csv(t, 'EMO-tagasiside2-emotions.csv')







# Background information --------------------------------------------------
library(tidyverse)

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/data/2022")

df <- read_delim("EMO2018 tagasisideuuring2 - EMO2018 tagasisideuuring2.csv", 
                 delim = ";", escape_double = FALSE, trim_ws = TRUE, col_names = FALSE)

bg = df[-c(1:2),c(1:2, 19, 25, 31, 36, 37)]
names(bg) = c("Algus", "Lõpp","Sugu", "Vanus", "Haridus", "Töötaatus:Õpin", "Tööstaatus:Töötan")
bg$ParticipantID = rep(1:139)

# reordering columns (ParticipantID as first)
bg = bg[, c(8, 1:7)]

# deleting bad rows
bg = bg[-c(2,3,6,12,14,15,18,19,26,27,41,42,47,53,55,57,61,69,70,71,74,76,77,79,82:84,89:91,95), ]

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/output/2022")
write_csv(bg, 'EMO-tagasiside2-background.csv')
