import os, sys

chr=sys.argv[1]

snp_keep_file = open("tmp_chr" + chr + "_snps_keep.txt")
snps_hash = {}
for line in snp_keep_file:
    e=line.strip().split()
    snps_hash[e[0]] = ""
snp_keep_file.close()

hap_file = out_file = open("tmp_chr" + chr + "_ref_select.txt")
out_file = open("tmp_chr" + chr + "_ref.txt", "w")
hap_file.readline() #skip the header line
for line in hap_file:
    e = line.strip().split()
    snp = e[0]
    if snp in snps_hash.keys():
        for i in range(1, len(e)-1):
            out_file.write(e[i] + " ")
        out_file.write(e[len(e)-1] + "\n")
hap_file.close()
out_file.close()
