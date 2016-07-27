#!/bin/bash

#Set parameters
if [ "$#" -eq  "0" ]
then
    echo "Usage: ${0##*/} <plink_file_prefix> <chr>"
    exit
fi
file=$1
chr=$2

#Create directories and ensure old output has been removed
mkdir ../data/intermediate
mkdir ../data/intermediate/shapeit_input
mkdir ../data/intermediate/shapeit_output
rm ../data/intermediate/shapeit_output/chr${chr}.*

#Create PLINK input files
grep -P "^$chr\t" ${file}.bim | \
    grep -P -v '0\t0\t[A|T|C|G|0]' | \
    cut -f2 > ../data/intermediate/shapeit_input/chr${chr}_snps.txt
plink --bfile ${file} \
      --extract ../data/intermediate/shapeit_input/chr${chr}_snps.txt \
      --make-bed --out ../data/intermediate/shapeit_input/chr${chr}

#Run shapeit
shapeit --input-bed  ../data/intermediate/shapeit_input/chr${chr}.bed \
        ../data/intermediate/shapeit_input/chr${chr}.bim \
        ../data/intermediate/shapeit_input/chr${chr}.fam \
        --input-map ../data/input/genetic_map_hapmap/chr${chr}.txt \
        --thread 8 \
        --output-max  ../data/intermediate/shapeit_output/chr${chr}.haps \
         ../data/intermediate/shapeit_output/chr${chr}.samples
