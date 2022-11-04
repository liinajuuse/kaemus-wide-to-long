eEMO2 = EMO_valideerimisuuring_2_completed_poolikud_22_02_24_wide_xlsx_Sheet1[,-c(93,94,235,236,377,378,519,520,662,663,804,805,946,947)] 
eEMO2 = eEMO2[, c(90:1069)]

emoraw_test = eEMO2

emoraw_column <- data.frame()

COLUMSREPEAT <- 10
COLUMSSHIFT <- 1
i <-0
#while((i+1)*COLUMSREPEAT+COLUMSSHIFT <= ncol(emoraw_test))
while(i < 98)
{
#  ID <- emoraw_test[1,i*COLUMSREPEAT+COLUMSSHIFT]
  #print(ID)
#  ID <- scan(text=as.character(ID), what=" ")[3]
  #print(ID)
#  ID <- substr(ID,1,nchar(ID)-1)
  #print(ID)
#  emoraw_test[2:nrow(emoraw_test),i*COLUMSREPEAT+COLUMSSHIFT] <- ID
#  print(ID)
  
  
  sub_emoraw <- emoraw_test[1:nrow(emoraw_test),(i*COLUMSREPEAT+COLUMSSHIFT):((i+1)*COLUMSREPEAT+COLUMSSHIFT-1)]
  names(sub_emoraw) <- NULL
  names(sub_emoraw) <- names( emoraw_test[2:nrow(emoraw_test),(1*COLUMSREPEAT+COLUMSSHIFT):((1+1)*COLUMSREPEAT+COLUMSSHIFT-1)])
#  sub_emoraw$KaemusParticipant = paste0(001:nrow(sub_emoraw), "_005") #unique participant nr per block; 001 indicates EMO2021-1 - EMO2021 valideerimisuuring - 1
  emoraw_column<- rbind(emoraw_column,sub_emoraw)
  i <- i+1
  print(i)
}  

write.csv2(emoraw_column, "EMO-valideerimisuuring-2-emotions-22-04-25.csv")
