###setting access to folder with DE expression tables
setwd("C:/Users/redaz/Documents/Uni/Master/RNA-seq/Steps/Step5/")
###importing table
sleuth_table_Novel<-read.csv(file="Novel_Significant_DE_Genes.csv")
###parsing the table to keep only low b values
sleuth_table_Novel_lowB<-sleuth_table_Novel[sleuth_table_Novel$b >= -0.5 & sleuth_table_Novel$b <= 0.5, ]
###checking for MSTRG.26634.1
sleuth_table_Novel_lowB[sleuth_table_Novel_lowB$target_id=="MSTRG.26634.1",]
