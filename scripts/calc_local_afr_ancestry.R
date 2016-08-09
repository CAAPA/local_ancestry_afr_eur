nr.indiv <- 7416
nr.haplos <- nr.indiv*2

frame <- data.frame()
for (chr in 1:22) {
   print(chr)
   calls <- read.table(paste0("../data/output/rfmix/chr", chr, "/local_ancestry.0.Viterbi.txt"))-1
   segments <- read.table(paste0("../data/output/rfmix/chr", chr, "/local_ancestry.0.SNPsPerWindow.txt"))
   prop.afr.anc <- rowSums(calls)/nr.haplos
   seg.nr <- 1:dim(segments)[1]
   chr.nr <- rep(chr, dim(segments)[1])
   nr.snps <- segments[,1]
   frame <- rbind(frame, data.frame(chr.nr, seg.nr, nr.snps, prop.afr.anc))
}

write.table(frame,
            "../data/output/local_ancestry_segments.txt",
            sep="\t", quote=F, row.names=F, col.names=T)

