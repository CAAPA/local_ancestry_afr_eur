args <- commandArgs(trailingOnly = TRUE)
nr.indiv <- as.integer(args[1])
nr.yri <- 108

yri.ids <- c(
  "NA18486", "NA18489", "NA18498", "NA18499", "NA18501", "NA18502", "NA18504", "NA18505",
  "NA18507", "NA18508", "NA18510", "NA18511", "NA18516", "NA18517", "NA18519", "NA18520",
  "NA18853", "NA18856", "NA18858", "NA18861", "NA18867", "NA18868", "NA18870", "NA18871",
  "NA18873", "NA18874", "NA18907", "NA18908", "NA18909", "NA18910", "NA18912", "NA18916",
  "NA18917", "NA18923", "NA18924", "NA18933", "NA18934", "NA19093", "NA19095", "NA19096",
  "NA19098", "NA19099", "NA19102", "NA19107", "NA19108", "NA19113", "NA19114", "NA19116",
  "NA19117", "NA19118", "NA19119", "NA19121", "NA19129", "NA19130", "NA19131", "NA19137",
  "NA19138", "NA19146", "NA19147", "NA19149", "NA19152", "NA19160", "NA19171", "NA19172",
  "NA19175", "NA19185", "NA19189", "NA19190", "NA19197", "NA19198", "NA19200", "NA19204",
  "NA19207", "NA19209", "NA19213", "NA19222", "NA19223", "NA19225", "NA19235", "NA19236",
  "NA19247", "NA19248", "NA19256", "NA19257"
)

fam <- read.table("../data/input/Admixture.fam", head=F)
adm <- read.table("../data/input/Admixture.3.Q", head=F)
yri.rows <- which(fam$V2 %in% yri.ids)
yri.anc <- adm[yri.rows,]
afr.col <- which.max(colMeans(yri.anc))

aa.rows <- grep("^WG0", fam$V2)
aa.ids <- fam[aa.rows,2] 
aa.yri.anc <- adm[aa.rows,afr.col]
frame <- data.frame(IID=aa.ids, ADMIXTURE_GW_AFR=aa.yri.anc)

write.table(frame, "../data/working/admixture_gwide.txt", sep="\t", quote=F, row.names=F, col.names=T)

      