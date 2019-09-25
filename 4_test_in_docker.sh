#!/bin/bash

# test your Singularity image within the Docker container first before deploying elsewhere
# resource files are mounted to /home/... in Docker but to /scratch/... on singularity

singularity exec \
    -B /home/bams:/scratch/bams \
    -B /home/ref:/scratch/ref \
    -B /home/regions:/scratch/regions \
    -B /home/results/:/scratch/results \
    --pwd /scratch/results gangstr-build.simg ./test_launcher.sh
