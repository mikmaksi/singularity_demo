#!/bin/bash 
echo "Running GangSTR test:"

# Note: make sure to change <REFFA> to name of actual fasta reference file

regions_bed='/scratch/regions/HTT.bed'
reffa='/scratch/ref/<REFFA>'

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
