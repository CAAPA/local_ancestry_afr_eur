rfmix <- read.delim("../data/working/rfmix_gwide.txt")
adm <- read.delim("../data/working/admixture_gwide.txt")
merged <- merge(rfmix, adm)
write.table(merged, "../data/output/merged_gwide.txt", sep="\t", quote=F, row.names=F, col.names=T)
