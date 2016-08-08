#!/bin/bash

nr_samples=7416
plink_file_name=../data/input/afr_am_bdos
rm -r ../data/working/*

#Calculate ADMIXTURE genome-wide ancestry
cat calc_admixture_gwide_ancestry.R | R --vanilla --args $nr_samples

#Calculate RFMIX genome-wide ancestry
cat calc_rfmix_gwide_ancestry.R | R --vanilla --args $nr_samples ${plink_file_name}.fam

#Create a combined genome-wide output file
cat merge_gwide_ancestry.R | R --vanilla

rm -r ../data/working/*
