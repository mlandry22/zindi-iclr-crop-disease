library(data.table)
setwd("/home/mark/competitions/zindi-crop-vision/")
ss<-fread("sample_submission.csv")

FILE_BASE<-"M27h"
original_output_file<-fread(paste0("fastai_out",FILE_BASE,".csv"))
original_output_file[,new_ID:=gsub(".JPG","",gsub(".jpg","",gsub("test/","",file_name,fixed = TRUE),fixed = TRUE),fixed = TRUE)]
fwrite(original_output_file[,.(ID=new_ID,leaf_rust,stem_rust,healthy_wheat)],paste0("fastai_sub",FILE_BASE,".csv"))
file.rename(from = paste0("fastai_out",FILE_BASE,".csv"),to = paste0("NO_SUBMIT_",FILE_BASE,".csv"))