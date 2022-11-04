library(readr)

#------EMO1 background-------

EMO2021_1_EMO2021_valideerimisuuring_1 <- read_delim("C:/Users/liina/OneDrive/PhD/EMO2021/EMO2021/22-04 Kaemus data wide to long/data/EMO2021-1 - EMO2021 valideerimisuuring - 1.csv", 
                                                     delim = ";", escape_double = FALSE, col_names = FALSE, 
                                                     trim_ws = TRUE)


EMO1_background = EMO2021_1_EMO2021_valideerimisuuring_1[, c(1:3, 19, 25, 31, 37, 42, 43, 44, 49, 55, 61, 67, 73, 79, 91, 98, 692, 698, 
                                                             704, 710, 716, 722, 728, 734, 740, 746, 752, 758, 764, 770, 776, 782, 788,
                                                             794, 800, 806, 812, 818, 824, 830, 836, 842, 848, 854, 860, 866, 872, 878, 
                                                             884, 890, 896, 902, 908, 914, 920, 926, 932, 938, 944)] # EMO1)]

names(EMO1_background) = c("Algus", "Lõpp", "IP", "Sugu", "Vanus", "Haridus", "Emakeel", "Töötaatus:Õpin", "Tööstaatus:Töötan", "Tööstaatus:Muu", "Eriala", 
                           "TegutsenudAastates", "EmoKirjandus", "EmoTunned", "Nipid", "Väsinud", "Näljane", "Tööala", "EMP1_40334", "MBS1_40350", "EMP2_40335", "MBS2_40351",
                           "EMP3_40336", "MBS3_40352", "EMP4_40337", "MBS4_40353", "EMP5_40338","MBS5_40354", "EMP6_40339", "MBS6_40355", "EMP7_40340", "MBS7_40356", "EMP8_40341",
                           "EMP9_40342", "EMP10_40343", "EMP11_40344", "EMP12_40345", "EMP13_40346","EMP14_40347", "EMP15_40348", "EMP16_40349", "Aktiivsena", "Elavana", "Elurõõmsana",
                           "Energilisena", "Enesekindlana", "Närvilisena", "Ärritatud", "Entusiastlik", "Häiritud", "Lustakas", "Rõõmus", "Rusutud", "Segaduses", "Tige", "TujustÄra",
                           "Tusane", "Tüdinud", "ÜlevasMeeleolus", "Vaimustuses", "Vihane")
EMO1_background = EMO1_background[-c(1:2),]

EMO1_background$KaemusParticipant = paste0(001:nrow(EMO1_background), "_001") 

EMO1_background = EMO1_background[,c(62, 1:61)]

write.csv2(EMO1_background, "EMO1-background-22-04-25.csv")

#------EMO4 background-------

EMO4_background = EMO2021_4_EMO2021_valideerimisuuring_4[, c(1:3, 19, 25, 31, 37, 42, 43, 44, 49, 55, 61, 67, 73, 79, 91, 98, 692, 698, 
                                                             704, 710, 716, 722, 728, 734, 740, 746, 752, 758, 764, 770, 776, 782, 788,
                                                             794, 800, 806, 812, 818, 824, 830, 836, 842, 848, 854, 860, 866, 872, 878, 
                                                             884, 890, 896, 902, 908, 914, 920, 926, 932, 938, 944)] # EMO4)]

names(EMO4_background) = c("Algus", "Lõpp", "IP", "Sugu", "Vanus", "Haridus", "Emakeel", "Töötaatus:Õpin", "Tööstaatus:Töötan", "Tööstaatus:Muu", "Eriala", 
                           "TegutsenudAastates", "EmoKirjandus", "EmoTunned", "Nipid", "Väsinud", "Näljane", "Tööala", "EMP1_40334", "MBS1_40350", "EMP2_40335", "MBS2_40351",
                           "EMP3_40336", "MBS3_40352", "EMP4_40337", "MBS4_40353", "EMP5_40338","MBS5_40354", "EMP6_40339", "MBS6_40355", "EMP7_40340", "MBS7_40356", "EMP8_40341",
                           "EMP9_40342", "EMP10_40343", "EMP11_40344", "EMP12_40345", "EMP13_40346","EMP14_40347", "EMP15_40348", "EMP16_40349", "Aktiivsena", "Elavana", "Elurõõmsana",
                           "Energilisena", "Enesekindlana", "Närvilisena", "Ärritatud", "Entusiastlik", "Häiritud", "Lustakas", "Rõõmus", "Rusutud", "Segaduses", "Tige", "TujustÄra",
                           "Tusane", "Tüdinud", "ÜlevasMeeleolus", "Vaimustuses", "Vihane")
EMO4_background = EMO4_background[-c(1:2),]

EMO4_background$KaemusParticipant = paste0(001:nrow(EMO4_background), "_004") 

EMO4_background = EMO4_background[,c(62, 1:61)]

EMO1_4_background = rbind(EMO1_background, EMO4_background)                                                 

#-----EMO5 background------

EMO5_background = EMO2021_5_EMO2021_valideerimisuuring_5[, c(1:3, 19, 25, 31, 37, 42, 43, 44, 49, 55, 61, 67, 73, 79, 91, 98, 692, 698, 
                                                             704, 710, 716, 722, 728, 734, 740, 746, 752, 758, 764, 770, 776, 782, 788,
                                                             794, 800, 806, 812, 818, 824, 830, 836, 842, 848, 854, 860, 866, 872, 878, 
                                                             884, 890, 896, 902, 908, 914, 920, 926, 932, 938, 944)] # EMO4)]

names(EMO5_background) = c("Algus", "Lõpp", "IP", "Sugu", "Vanus", "Haridus", "Emakeel", "Töötaatus:Õpin", "Tööstaatus:Töötan", "Tööstaatus:Muu", "Eriala", 
                           "TegutsenudAastates", "EmoKirjandus", "EmoTunned", "Nipid", "Väsinud", "Näljane", "Tööala", "EMP1_40334", "MBS1_40350", "EMP2_40335", "MBS2_40351",
                           "EMP3_40336", "MBS3_40352", "EMP4_40337", "MBS4_40353", "EMP5_40338","MBS5_40354", "EMP6_40339", "MBS6_40355", "EMP7_40340", "MBS7_40356", "EMP8_40341",
                           "EMP9_40342", "EMP10_40343", "EMP11_40344", "EMP12_40345", "EMP13_40346","EMP14_40347", "EMP15_40348", "EMP16_40349", "Aktiivsena", "Elavana", "Elurõõmsana",
                           "Energilisena", "Enesekindlana", "Närvilisena", "Ärritatud", "Entusiastlik", "Häiritud", "Lustakas", "Rõõmus", "Rusutud", "Segaduses", "Tige", "TujustÄra",
                           "Tusane", "Tüdinud", "ÜlevasMeeleolus", "Vaimustuses", "Vihane")

EMO5_background = EMO5_background[-c(1:2),]

EMO5_background$KaemusParticipant = paste0(001:nrow(EMO5_background), "_005") 

EMO5_background = EMO5_background[,c(62, 1:61)]

EMO145_background = rbind(EMO1_4_background, EMO5_background)

write.csv2(EMO145_background, "EMO145_background.csv")
