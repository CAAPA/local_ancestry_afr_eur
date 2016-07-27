#!/bin/bash

plink --bfile ../../caapa_imputation_pipeline/data/output/typed_overlap/afr_am \
      --bmerge ../../caapa_imputation_pipeline/data/output/typed_overlap/jhu_bdos.bed \
      ../../caapa_imputation_pipeline/data/output/typed_overlap/jhu_bdos.bim \
      ../../caapa_imputation_pipeline/data/output/typed_overlap/jhu_bdos.fam \
      --make-bed --out ../data/working/dummy_merge

if [ -e "../data/working/dummy_merge-merge.missnp" ]
then
    plink --bfile ../../caapa_imputation_pipeline/data/output/typed_overlap/jhu_bdos \
          --flip ../data/working/dummy_merge-merge.missnp \
          --make-bed --out ../data/working/tmp_flipped
    rm ../data/working/dummy_merge-merge.missnp
    plink --bfile ../../caapa_imputation_pipeline/data/output/typed_overlap/afr_am \
      --bmerge ../data/working/tmp_flipped.bed \
      ../data/working/tmp_flipped.bim \
      ../data/working/tmp_flipped.fam \
      --make-bed --out ../data/input/afr_am_bdos
else
    plink --bfile ../data/working/dummy_merge \
          --make-bed --out ../data/input/afr_am_bdos
fi

rm ../data/working/*
