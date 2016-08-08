#!/bin/bash

#Set parameters
if [ "$#" -eq  "0" ]
then
    echo "Usage: ${0##*/} <chr>"
    exit
fi
chr=$1

#Make directories for saving RFmix input files
mkdir ../data/input/rfmix
rm -r ../data/input/rfmix/chr${chr}
mkdir ../data/input/rfmix/chr${chr}

#Get list of hapmap SNPs that are in genetic map and also their ref alleles
cut -f2 -d' ' ../data/input/genetic_map_tgp/chr${chr}.txt | sort -k1 > tmp_chr${chr}_map_sorted.txt
cat ../data/input/tgp/chr${chr}.impute.legend | grep ^rs | sort -k2 > tmp_chr${chr}_tgp_sorted.txt
cat ../data/input/tgp/chr${chr}.impute.legend | grep ^rs | sort -k2 | cut -f2 -d' ' | uniq -u > tmp_chr${chr}_tgp_unique.txt
join tmp_chr${chr}_map_sorted.txt tmp_chr${chr}_tgp_unique.txt > tmp_chr${chr}_unique.txt
join -1 1 -2 2 tmp_chr${chr}_unique.txt tmp_chr${chr}_tgp_sorted.txt > tmp_chr${chr}_tgp_mapped.txt

#Get admixed SNPs that are in the tmp_map and
#-is not AT/CG
#-do not have allele mismatches
#-determine if ref SNP has changed
cat ../data/intermediate/shapeit_output/chr${chr}.haps | cut -f2-5 -d ' ' > tmp_chr${chr}_admixed.txt
python get_admixed_snps.py $chr

#Rewrite the reference population file to contain only the SNPs to keep
sed -e '1d'  ../data/input/tgp/chr${chr}.impute.legend | cut -f2 -d' '  | sed "s/^/${chr}:/" > \
                                                             tmp_chr${chr}_ref_snps.txt
paste tmp_chr${chr}_ref_snps.txt  ../data/input/tgp/chr${chr}.impute.hap > \
       tmp_chr${chr}_ref_select.txt
python get_ref_haps.py $chr

#Rewrite the admixed file to contain only the SNPs to keep, and change 0/1 codings where necessary
python get_admixed_haps.py $chr

#Create the alleles.txt file
paste -d' ' tmp_chr${chr}_admixed.txt tmp_chr${chr}_ref.txt  > tmp_chr${chr}_alleles.txt
sed 's/ //g' tmp_chr${chr}_alleles.txt > ../data/input/rfmix/chr${chr}/alleles.txt

#Create the classes.txt file
python create_classes.py $chr

#Create the snp_locations.txt file
python create_snp_locations.py $chr
