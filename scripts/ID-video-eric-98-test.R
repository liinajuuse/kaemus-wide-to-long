library(tidyverse)

# test_ = Valideerimisuuring1_kustutasin98[, -c(976:987, 1660:1671, 2344:2355, 3028:3039, 3712:3723, 4396:4407, 5080:5091)] EMO1
# test = test_[, 970:5673] EMO1

test_ = Valideerimisuuring4_kustutasin28[,-c(1553:1564, 1805:1816, 1913:1924, 2597:2608, 2849:2860, 3053:3064, 4121:4132)] # EMO4
# kas tunned küsimusi küsitakse randomiseeritult ja seega pean igast setist need special kohast välja võtma (siis muidugi ei peaks, kui
# ma oskaks neid nime järgi välja võtta, aga seal on ka see + 7 järgmist rida teema)
test = test_[, 971:5674] # EMO4

test_ = Valideerimisuuring5_kustutasin27[,-c(977:988, 1661:1672, 2345:2356, 3029:3040, 3713:3724, 4397:4408, 5081:5092)] #EMO5
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
  sub_emoraw$KaemusParticipant = paste0(1:nrow(sub_emoraw), "_001") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  emoraw_column<- rbind(emoraw_column,sub_emoraw)
  i <- i+1
  print(i)
}  


emoraw_column <- merge(emoraw_column, test5, by.x = "V1019", by.y ="KaemusID")

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

EMO3 = te

names(EMO1) = c("KaemusID", "KaemusJrk", "Valence", "Arousal", "Emotion1", "Intensity1", "Emotion2", "Intensity2", "Natural", "KaemusParticipant", "VideoID", "EmotionID", "Condition")
EMO_1_4_5 = rbind(EMO1, EMO2, EMO3, setNames(rev(EMO1), names(EMO1)))

write_csv(EMO_1_4_5, "EMO-valideerimisuuring-145-Hans.csv")
write_csv(EMO1, "EMO-valideerimisuuring-145-Lenna.csv")