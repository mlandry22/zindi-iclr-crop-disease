library(data.table)
#setwd("/home/mark/competitions/zindi-crop-vision/")
#ss<-fread("sample_submission.csv")

#### AJL X
s27g<-fread("fastai_subM27g.csv"); w27g<-69.0 ## 0.246061, 50/10 d201 1%cv
s26c<-fread("fastai_subM26c.csv"); w26c<-57.3 ## 0.24963, 1%cv 70/5 res152
s24f<-fread("fastai_subM24f.csv"); w24f<-51.5 ## 0.25993, 40/10 dense201
s26d<-fread("fastai_subM26d.csv"); w26d<-31.3 ## 0.26277, 1%cv 70/5 res152
s27h<-fread("fastai_subM27h.csv"); w27h<-1.7 ## 0.26742, 45/15 d201 1%cv
s23k<-fread("fastai_subM23k.csv"); w23k<-1.2 ## 0.27098, 50/1 lr-norm d201
s23f<-fread("fastai_subM23f.csv"); w23f<-1.1 ## 0.27310, 50/10 mixup dense201
s27a<-fread("fastai_subM27a.csv"); w27a<-0.7 ## 0.27592, dense161
s27f<-fread("fastai_subM27f.csv"); w27f<-0.5 ## 0.27814, 45/10 d201 1%cv
s26f<-fread("fastai_subM26f.csv"); w26f<-0.3 ## 0.27974, 1%cv 75/5 res152
blend<-copy(s27g)
wVec<-c(w27g,w26c,w24f,w26d,w27h,w23k,w23f,w27a,w27f,w26f)
wSum<-sum(wVec)
wVec/wSum

blend[,`:=`(
  leaf_rust=(     w27a*s27a$leaf_rust +     w26d*s26d$leaf_rust       + w26c*s26c$leaf_rust +     w24f*s24f$leaf_rust +     w23k*s23k$leaf_rust +     w23f*s23f$leaf_rust +
                    w27h*s27h$leaf_rust     + w27g*s27g$leaf_rust     + w27f*s27f$leaf_rust +     w26f*s26f$leaf_rust
  )/wSum
  ,stem_rust=(    w27a*s27a$stem_rust +     w26d*s26d$stem_rust       + w26c*s26c$stem_rust +     w24f*s24f$stem_rust +     w23k*s23k$stem_rust +     w23f*s23f$stem_rust +
                    w27h*s27h$stem_rust     + w27g*s27g$stem_rust     + w27f*s27f$stem_rust +     w26f*s26f$stem_rust
  )/wSum
  ,healthy_wheat=(w27a*s27a$healthy_wheat + w26d*s26d$healthy_wheat   + w26c*s26c$healthy_wheat + w24f*s24f$healthy_wheat + w23k*s23k$healthy_wheat + w23f*s23f$healthy_wheat +
                    w27h*s27h$healthy_wheat + w27g*s27g$healthy_wheat + w27f*s27f$healthy_wheat + w26f*s26f$healthy_wheat
  )/wSum
)]
wVec<-c(w27g,w26c,w24f,w26d,w27h,w23k,w23f,w27a,w27f,w26f)
fwrite(blend[,.(ID,leaf_rust,stem_rust,healthy_wheat)],"fastai_ajlX.csv")
