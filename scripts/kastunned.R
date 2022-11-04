library(tidyverse)
library(readr)
test_ = EMO2021_1_EMO2021_valideerimisuuring_1[, c(970, 980, 986, 1654, 1664, 1670, 2338, 2348, 2354, 3022, 3032, 3038, 3706, 3716, 3722, 4390, 4400, 4406, 5074, 5084, 5090)] #EMO1

test_ = EMO2021_4_EMO2021_valideerimisuuring_4[, c(1547, 1557, 1563, 1799, 1809, 1815, 1907, 1917, 1923, 2591, 2601, 2607, 2843, 2853, 2859, 3047, 3057, 3063, 4115, 4125, 4131)] # EMO4

test_ = EMO2021_5_EMO2021_valideerimisuuring_5[, c(971, 981, 987, 1655, 1665, 1671, 2339, 2349, 2355, 3023, 3033, 3039, 3707, 3717, 3723, 4391, 4401, 4407, 5075, 5085, 5091)] #EMO5

emoraw_test = test_
test5 = EMO2021_VideoID_KaemuseID_1_clean #desktopilt sellenimeline fail, kõik KaemusID-d ja VideoID-d

emoraw_column <- data.frame()

COLUMSREPEAT <- 3
COLUMSSHIFT <- 1
i <-0
#while((i+1)*COLUMSREPEAT+COLUMSSHIFT <= ncol(emoraw_test))
while(i < 7)
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
  emoraw_column<- rbind(emoraw_column,sub_emoraw)
  i <- i+1
  print(i)
}  

names(emoraw_column) = c("KaemusID", "Know", "Seen", "KaemusParticipant")

new_dataset1 <- EMO1 %>% left_join(emoraw_column, by=c("KaemusID","KaemusParticipant"))

new_dataset4 <- EMO4 %>% left_join(emoraw_column, by=c("KaemusID","KaemusParticipant"))

new_dataset5 <- EMO5 %>% left_join(emoraw_column, by=c("KaemusID","KaemusParticipant"))

EMO_1_4_5_seen = rbind(new_dataset1, new_dataset4, new_dataset5)

write.csv2(EMO_1_4_5_seen, "EMO2021-valideerimisuuring-1-4-5-long.csv")
write.csv2(new_dataset1, "EMO2021-valideerimisuuring-1-long.csv")

write.csv(EMO_1_4_5_seen, "EMO2021-valideerimisuuring-1-4-5-long.csv")
