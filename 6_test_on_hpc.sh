#!/bin/bash
#PBS -q hotel
#PBS -N singularity_test
#PBS -l nodes=1:ppn=1
#PBS -l walltime=30:00
#PBS -o job.o
#PBS -e job.e 
#PBS -V

# NOTE: make sure to replace <SCRATCH_PATH>,  <PATH_TO_REF> and <ANALYSIS_DIR> with actual variables

# cd into the launch directory
results_dir="<SCRATCH_PATH>/${USER}/<ANALYSIS_DIR>"
cd $results_dir

# mount paths and set singularity image name to use
bam_dir='test/alignment'
regions_dir='test'
ref_dir='<PATH_TO_REF>'
simg='gangstr-build.simg'

# there is a bug in Singularity which causses a "Too many levels of symbolic links" error
# this only happens on first try
# attempt path binding with dummy command
singularity exec \
    -B ${bam_dir}:/scratch/bams:ro \
    -B ${ref_dir}:/scratch/ref:ro \
    -B ${regions_dir}:/scratch/regions:ro \
    -B ${results_dir}:/scratch/results:rw \
    --pwd /scratch/results $simg ls

# launch jobs for real
singularity exec \
    -B ${bam_dir}:/scratch/bams \
    -B ${ref_dir}:/scratch/ref \
    -B ${regions_dir}:/scratch/regions \
    -B ${results_dir}:/scratch/results \
    --pwd /scratch/results $simg ./hpc_launcher.sh > ${results_dir}/job.log 2>&1
