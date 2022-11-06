# The script for data manipulations in the 

# Libraries, data, directory ----------------------------------------------
library(tidyverse)

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/data/2022")

# original df 
df <- read_delim("EMO2021-2 - EMO2021 valideerimisuuring - 2.csv", 
                 delim = ";", escape_double = FALSE, col_names = FALSE, 
                 trim_ws = TRUE)

# IDs to match Kaemus with Videos
VideoID <- read_csv("VideoID.csv")

# võtan kohe tühjad vastajad maha
u = df[-c(4,5,8,9,23,29,30,32:39,47:51,53:84,86:100,102,104:108,112:118), ]


# Emotsioonide osa --------------------------------------------------------

# kas tunned küsimuste väljavõtmine
# kas tunned küsimusi küsitakse randomiseeritult ja seega pean igast setist need special kohast välja võtma (siis muidugi ei peaks, kui
# ma oskaks neid nime järgi välja võtta, aga seal on ka see + 7 järgmist rida teema)
# salvestan eraldi
kastunned = u[, c(1054:1065, 1738:1749, 2422:2433, 3106:3117, 3790:3801, 4474:4485, 5158:5169)]

# võtan peafailist maha
u = u[, -c(1054:1065, 1738:1749, 2422:2433, 3106:3117, 3790:3801, 4474:4485, 5158:5169)]

# eraldan emotsioonide osa
u = u[, 1048:5751]


# 48 columniga loop
emoraw_test <- u
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
  sub_emoraw$KaemusParticipant = paste0(001:nrow(sub_emoraw), "_002") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  emoraw_column<- rbind(emoraw_column,sub_emoraw)
  i <- i+1
  print(i)
}  

emoraw_column <- merge(emoraw_column, VideoID, by.x = "X1108", by.y ="KaemusID") #EMO1

# soovitud veerud
emoraw_column = emoraw_column[c(1,2,10,16,23,28,35,40,46,49,50)]
names(emoraw_column) = c("KaemusID", "KaemusJrk", "Valence", "Arousal", "Emotion1", "Intensity1", "Emotion2", "Intensity2", "Natural", "KaemusParticipant", "VideoID")

# sort by KaemusParticipant
emoraw_column <- emoraw_column[order(emoraw_column$KaemusParticipant),]

#add emotion and condition based on VideoID
emoraw_column = emoraw_column %>% 
  mutate(EmotionID = str_sub(VideoID, -4)) %>% 
  mutate(EmotionID = substr(EmotionID, 3, 3)) %>% 
  mutate(EmotionID = recode(EmotionID, "6" = "Neutraalne", "1" = "Vastikus", "2" = "Üllatus", "3" = "Kurbus", "4" = "Viha",
                            "5" = "Hirm", "7" = "Rõõm")) %>% 
  mutate(Condition = sapply(strsplit(VideoID, split="_"), "[", 4)) %>% 
  mutate(Condition = as.numeric(Condition)) %>% 
  mutate(Condition = ifelse(Condition < 16, "Ekman", "Under")) %>% 
  mutate(ParticipantID = sapply(strsplit(VideoID, split = "_"), "[", 2))

dropna = emoraw_column %>% drop_na(Emotion1)

# dropna on juba üsna informatiivne tabel, aga tudengitele oleks tn lihtsam, kui oleks vähem informatsiooni
# salvestan selle tabeli ära ja siis lõikan Emotion1, Target jne jne välja

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/output/2022")
write_csv(dropna, 'EMO2-emotions-full.csv')

# võtan dropna failist KaemusID, Emotion1, KaemusParticipant, EmotionID, Condition, ParticipantID
n <-dropna[, c(1,5, 10, 12, 13, 14)]

# muudan nimesid veits
names(n) <- c("KaemusID", "Emotion1_A", "KaemusParticipant", "Emotion_T", "Condition", "VideoParticpant")

# hit or miss variable
n$Hit = ifelse(n$Emotion1_A == n$Emotion_T, 1, 0)

# saving student EMO2 file
write_csv(n, 'EMO2-emotions-short.csv')





# Background information --------------------------------------------------
library(tidyverse)

setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/data/2022")

# original df 
df <- read_delim("EMO2021-2 - EMO2021 valideerimisuuring - 2.csv", 
                 delim = ";", escape_double = FALSE, col_names = FALSE, 
                 trim_ws = TRUE)

# võtan kohe tühjad vastajad maha
df = df[-c(4,5,8,9,23,29,30,32:39,47:51,53:84,86:100,102,104:108,112:118), ]

df <- df[-c(1:2),]

# lisan ID, millega pärast emotsioonide df siduda
df$KaemusParticipant <- paste0(1:nrow(df), "_002")
  
bg <- df[, c(1, 2, 19, 25, 31, 37, 42, 43, 44, 49, 55, 61, 67, 73, 79, 91, 98, 692, 698, 
             704, 710, 716, 722, 728, 734, 740, 746, 752, 758, 764, 770, 776, 782, 788,
             794, 800, 806, 812, 818, 824, 830, 836, 842, 848, 854, 860, 866, 872, 878, 
             884, 890, 896, 902, 908, 914, 920, 926, 932, 938, 944, 5891)] # EMO2)]]

names(bg) = c("Algus", "Lõpp", "Sugu", "Vanus", "Haridus", "Emakeel", "Töötaatus:Õpin", "Tööstaatus:Töötan", "Tööstaatus:Muu", "Eriala", 
                           "TegutsenudAastates", "EmoKirjandus", "EmoTunned", "Nipid", "Väsinud", "Näljane", "Tööala", "EMP1_40334", "MBS1_40350", "EMP2_40335", "MBS2_40351",
                           "EMP3_40336", "MBS3_40352", "EMP4_40337", "MBS4_40353", "EMP5_40338","MBS5_40354", "EMP6_40339", "MBS6_40355", "EMP7_40340", "MBS7_40356", "EMP8_40341",
                           "EMP9_40342", "EMP10_40343", "EMP11_40344", "EMP12_40345", "EMP13_40346","EMP14_40347", "EMP15_40348", "EMP16_40349", "Aktiivsena", "Elavana", "Elurõõmsana",
                           "Energilisena", "Enesekindlana", "Närvilisena", "Ärritatud", "Entusiastlik", "Häiritud", "Lustakas", "Rõõmus", "Rusutud", "Segaduses", "Tige", "TujustÄra",
                           "Tusane", "Tüdinud", "ÜlevasMeeleolus", "Vaimustuses", "Vihane", "KaemusParticipant")



bg <- bg[bg$KaemusParticipant %in% n$KaemusParticipant, ]

# tudengitele väiksem osa
st <- bg[ ,c(1:6,8,17,61)]

# kirjutan Janeli/Valeria faili, kus on ainult sugu, haridus, tööala, emakeel jne
setwd("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/kaemus-wide-to-long/output/2022")
write_csv(st, 'EMO2-background.csv')
