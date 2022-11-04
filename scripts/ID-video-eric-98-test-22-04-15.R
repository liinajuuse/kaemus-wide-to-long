library(here)
library(tidyverse)
library(readr)
# need failid nüüd C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/22-04 Kaemus data wide to long/output
# proovi pärast here() kasutada, see directib mind projekti folderisse ja siis sealt
# here()
# here("some", "path", "below", "your", "project", "root.txt")
# here("some/path/below/your/project/root.txt")


df <- read_delim("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/22-04 Kaemus data wide to long/data/EMO2021-1 - EMO2021 valideerimisuuring - 1.csv", 
                                                                      delim = ";", escape_double = FALSE, col_names = FALSE, 
                                                                      trim_ws = TRUE)

# kas tunned küsimuste väljavõtmine
# kas tunned küsimusi küsitakse randomiseeritult ja seega pean igast setist need special kohast välja võtma (siis muidugi ei peaks, kui
# ma oskaks neid nime järgi välja võtta, aga seal on ka see + 7 järgmist rida teema)
EMO2021_1_EMO2021_valideerimisuuring_1[,976]
test_ = EMO2021_1_EMO2021_valideerimisuuring_1[, -c(976:987, 1660:1671, 2344:2355, 3028:3039, 3712:3723, 4396:4407, 5080:5091)] #EMO1
test = test_[, 970:5673] # EMO1

EMO2021_4_EMO2021_valideerimisuuring_4 <- read_delim("C:/Users/liina/Desktop/EMO2021-HansDatasetid-Puhastamine/EMO2021-4 - EMO2021 valideerimisuuring - 4.csv", 
                                                     delim = ";", escape_double = FALSE, na = "empty", col_names = F, trim_ws = TRUE)
EMO2021_4_EMO2021_valideerimisuuring_4[,1553]
test_ = EMO2021_4_EMO2021_valideerimisuuring_4[,-c(1553:1564, 1805:1816, 1913:1924, 2597:2608, 2849:2860, 3053:3064, 4121:4132)] # EMO4


EMO2021_5_EMO2021_valideerimisuuring_5 <- read_delim("C:/Users/liina/Desktop/EMO2021-HansDatasetid-Puhastamine/EMO2021-5 - EMO2021 valideerimisuuring - 5.csv", 
                                                     delim = ";", escape_double = FALSE, col_names = FALSE,
                                                     na = "empty", trim_ws = TRUE)
EMO2021_5_EMO2021_valideerimisuuring_5[,971]
test_ = EMO2021_5_EMO2021_valideerimisuuring_5[,-c(977:988, 1661:1672, 2345:2356, 3029:3040, 3713:3724, 4397:4408, 5081:5092)] #EMO5
test = test_[, 971:5674] # EMO5


emoraw_test = test
test5 = EMO2021_VideoID_KaemuseID_1_clean #desktopilt sellenimeline fail, kõik KaemusID-d ja VideoID-d

emoraw_column <- data.frame()

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
  sub_emoraw$KaemusParticipant = paste0(001:nrow(sub_emoraw), "_005") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  emoraw_column<- cbind(emoraw_column,sub_emoraw)
  i <- i+1
  print(i)
}  

emoraw_column <- merge(emoraw_column, test5, by.x = "X1030", by.y ="KaemusID") #EMO1
emoraw_column <- merge(emoraw_column, test5, by.x = "X1019", by.y ="KaemusID") #EMO4
emoraw_column <- merge(emoraw_column, test5, by.x = "X1031", by.y ="KaemusID") #EMO5

emo_delete = emoraw_column[c(1,2,10,16,23,28,35,40,46,49,50)]
names(emo_delete) = c("KaemusID", "KaemusJrk", "Valence", "Arousal", "Emotion1", "Intensity1", "Emotion2", "Intensity2", "Natural", "KaemusParticipant", "VideoID")

#add emotion and condition based on VideoID
emo_delete = emo_delete %>%
  mutate(EmotionID = str_sub(VideoID, -4)) %>% 
  mutate(EmotionID = substr(EmotionID, 3, 3)) %>%
  mutate(EmotionID = recode(EmotionID, "6" = "Neutraalne", "1" = "Vastikus", "2" = "Üllatus", "3" = "Kurbus", "4" = "Viha",
                          "5" = "Hirm", "7" = "Rõõm")) %>% 
  mutate(Condition = sapply(strsplit(VideoID, split="_"), "[", 4)) %>% 
  mutate(Condition = as.numeric(Condition)) %>% 
  mutate(Condition = ifelse(Condition < 16, "Ekman", "Under"))

te = emo_delete[!emo_delete$Emotion1=="",]

EMO1 = te
EMO4 = te
EMO5 = te
#names(EMO5) = c("KaemusID", "KaemusJrk", "Valence", "Arousal", "Emotion1", "Intensity1", "Emotion2", "Intensity2", "Natural", "KaemusParticipant", "VideoID", "EmotionID", "Condition")
EMO_1_4_5 = rbind(EMO1, EMO4, EMO5)
EMO_1_4_5 = rbind(EMO_1_4_5, EMO5)

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/22-04 Kaemus data wide to long/output")
write.csv2(EMO_1_4_5, "EMO-valideerimisuuring-145-Hans.csv")
write.csv2(EMO1, "EMO-valideerimisuuring-1-Lenna.csv")
write.csv2(EMO4, "EMO-valideerimisuuring-4.csv")
write.csv2(EMO5, "EMO-valideerimisuuring-5.csv")
write.csv2(EMO_1_4_5, "EMO-valideerimisuuring-145-Hans.csv")
