#!/bin/bash

#Set parameters
if [ "$#" -eq  "0" ]
then
    echo "Usage: ${0##*/} <chr>"
    exit
fi
chr=$1

#Make directories for saving RFmix output files
mkdir ../data/output/rfmix
rm -r ../data/output/rfmix/chr${chr}
mkdir ../data/output/rfmix/chr${chr}

#Create input files
bash create_rfmix_input.sh $chr
cp tmp_chr${chr}_snps_keep.txt ../data/output/rfmix/chr${chr}/snps.txt

#Run RFMix
RFMix_TrioPhased -a ../data/input/rfmix/chr${chr}/alleles.txt \
                  -p ../data/input/rfmix/chr${chr}/classes.txt \
                  -m ../data/input/rfmix/chr${chr}/snp_locations.txt \
                  -co 1 -o ../data/output/rfmix/chr${chr}/local_ancestry

#Cleanup
rm tmp*chr${chr}*
