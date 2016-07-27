#!/bin/bash

rm -r ../data/input/tgp
mkdir ../data/input/tgp

date > vcf_extract_begin_time.txt
for chr in {1..22..1}
do
	vcftools --gzvcf ../data/raw/tgp_release_20130502/ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --out ../data/input/tgp/chr${chr} --phased --IMPUTE --keep ../data/raw/tgp_release_20130502/ceu_yri_ids.txt
done
date > vcf_extract_end_time.txt
