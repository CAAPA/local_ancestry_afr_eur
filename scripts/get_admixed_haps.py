import os, sys

chr=sys.argv[1]

snp_keep_file = open("tmp_chr" + chr + "_snps_keep.txt")
snps_hash = {}
for line in snp_keep_file:
    e=line.strip().split()
    snps_hash[e[0]] = e[1]
snp_keep_file.close()

hap_file = open("../data/intermediate/shapeit_output/chr" + chr + ".haps")
out_file = open("tmp_chr" + chr + "_admixed.txt", "w")
for line in hap_file:
    e=line.strip().split()
    snp = e[1]
    if snp in snps_hash.keys():
        flip_code = snps_hash[snp]
        if flip_code == "0":
            for i in range(5, len(e)-1):
                out_file.write(e[i] + " ")
            out_file.write(e[len(e)-1] + "\n")
        else:
            for i in range(5, len(e)-1):
                if e[i] == "0":
                    out_file.write("1 ")
                else:
                    out_file.write("0 ")
            if e[len(e)-1] == "0":
                out_file.write("1\n")
            else:
                out_file.write("0\n")
hap_file.close()
out_file.close()
