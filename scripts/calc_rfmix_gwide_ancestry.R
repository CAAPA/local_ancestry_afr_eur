args <- commandArgs(trailingOnly = TRUE)
nr.indiv <- as.integer(args[1])
fam.file.name  <- args[2]
#nr.indiv <- 7416
#fam.file.name <- "../data/input/afr_am_bdos.fam" #Assumes that sample ID is in the 2nd column
nr.haplos <- nr.indiv*2

total.nr.snps <- 0
total.nr.afr.snps <- as.matrix(rep(0, nr.haplos))
for (chr in 1:22) {
  snps.per.win <- read.table(paste0("../data/output/rfmix/chr", chr, "/local_ancestry.0.SNPsPerWindow.txt"))
  anc <- read.table(paste0("../data/output/rfmix/chr", chr, "/local_ancestry.0.Viterbi.txt"))
  nr.snps <- sum(snps.per.win$V1)
  nr.snps.check <- dim(read.delim(paste0("../data/output/rfmix/chr", chr, "/snps.txt"), head=F, sep=" "))[1]
  if (nr.snps != nr.snps.check) {
    print(paste0("ERROR! number of SNPs does not check out for chromosome ",
                chr,
                "Should be ", nr.snps.check, "; is ", nr.snps))
  }
  nr.afr.snps <- (as.matrix(t(anc))-1)%*%as.matrix(snps.per.win)
  total.nr.afr.snps <- total.nr.afr.snps + nr.afr.snps
  total.nr.snps <- total.nr.snps + nr.snps
}

frame <- data.frame(IID=read.table(fam.file.name)[,2])
frame$IID <- substring(frame$IID,1,16)
frame$RFMIX_GW_AFR <- NA
k <- 0
for (i in seq(1,nr.haplos,2)) {
    k <- k + 1
    frame$RFMIX_GW_AFR[k] <- (total.nr.afr.snps[i] + total.nr.afr.snps[i+1])/(2*total.nr.snps)
}

write.table(frame, "../data/working/rfmix_gwide.txt", sep="\t", quote=F, row.names=F, col.names=T)

