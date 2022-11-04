emoraw_test = EMO2021_1_48
test5 = EMO2021_VideoID_KaemuseID_1_clean

emoraw_column <- data.frame()

#emoraw_test <- emoraw[5663:5760]
COLUMSREPEAT <- 48
COLUMSSHIFT <- 1
i <-1
while(i <= 98)
{
  ID <- emoraw_test[1,i*COLUMSREPEAT+COLUMSSHIFT]
  ID <- scan(text=as.character(ID), what=" ")[3]
  ID <- substr(ID,1,nchar(ID)-1)
  print(ID)
  emoraw_test[2:nrow(emoraw_test),i*COLUMSREPEAT+COLUMSSHIFT] <- ID
  
  
  sub_emoraw <- emoraw_test[3:nrow(emoraw_test),(i*COLUMSREPEAT+COLUMSSHIFT):((i+1)*COLUMSREPEAT+COLUMSSHIFT-1)]
  names(sub_emoraw) <- NULL
  names(sub_emoraw) <- names( emoraw_test[2:nrow(emoraw_test),(1*COLUMSREPEAT+COLUMSSHIFT):((1+1)*COLUMSREPEAT+COLUMSSHIFT-1)])
  sub_emoraw$KaemusParticipant = paste0(1:nrow(sub_emoraw), "_001") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  emoraw_column<- rbind(emoraw_column,sub_emoraw)
  i <- i+1
}  


emoraw_column <- merge(emoraw_column, test5, by.x = "...49", by.y ="KaemusID")

#delete useless columns
