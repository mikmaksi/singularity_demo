#!/bin/bash 
echo "Running GangSTR test:"

regions_bed='/scratch/regions/HTT.bed'
reffa='/scratch/ref/GRCh38_full_analysis_set_plus_decoy_hla.fa'

# run gangstr
for bam in /scratch/bams/*.bam
do
    name=$(basename $bam .sorted.bam)
    echo Sample: $name
    GangSTR --bam $bam \
        --regions $regions_bed \
        --ref $reffa \
        --coverage 50 \
	--output-readinfo \
	--verbose \
	--out no_save/no_save
done
