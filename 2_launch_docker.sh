#!/bin/bash

# launch an interactive Docker container
# make sure to use --rm to delete container upon exit
# mount some paths with resources for GangSTR
# mount current directory to /home/results and start container there
bam_dir="$(pwd)/test/alignment"
regions_dir="$(pwd)/test"
ref_dir='/storage/resources/dbase/human/GRCh38/'
docker run -it --rm \
    --privileged \
    -v  $bam_dir:/home/bams:ro \
    -v  $regions_dir:/home/regions:ro \
    -v  $ref_dir:/home/ref:ro \
    -v $(pwd):/home/results:rw \
    -w /home/results \
    singularity