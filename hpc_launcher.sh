#!/bin/bash 
echo "Running GangSTR test:"

regions_bed='/scratch/regions/HTT.bed'
reffa='/scratch/ref/hg38.fa'

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
