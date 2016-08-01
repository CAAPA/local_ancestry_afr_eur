import os, sys

chr=sys.argv[1]

snp_keep_file = open("tmp_chr" + chr + "_snps_keep.txt")
snps_hash = {}
for line in snp_keep_file:
    e=line.strip().split()
    snps_hash[e[0]] = ""
snp_keep_file.close()

map_file = open("../data/input/genetic_map_tgp/chr" + chr + ".txt")
cm_hash = {}
for line in map_file:
    e=line.strip().split()
    snp=e[0]
    cm=e[2]
    if snp in snps_hash.keys():
        cm_hash[snp] = cm
map_file.close()

hap_file = open("../data/intermediate/shapeit_output/chr" + chr + ".haps")
out_file = open("../data/input/rfmix/chr" + chr + "/snp_locations.txt", "w")
i = 0
for line in hap_file:
    e=line.strip().split()
    snp = e[1]
    if snp in snps_hash.keys():
        if snp in cm_hash:
            out_file.write(cm_hash[snp] + "\n")
        #For those SNPs that have different rs IDs but match in position and alleles - these are rare
        else:
            pos=os.popen("grep ' " + snp + " ' tmp_chr" + chr + "_tgp_mapped.txt | cut -f1 -d' '").read().strip()
            cm=os.popen("grep ' " + pos + " ' ../data/input/genetic_map_tgp/chr" + chr + ".txt | cut -f3 -d' '").read().strip()
            out_file.write(cm + "\n")
    i = i + 1
hap_file.close()
out_file.close()
