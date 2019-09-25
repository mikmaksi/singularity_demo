# Example code for using Singularity on an HPC cluster

This example describes a typical workflow for building a Singularity image and deploying it on an HPC cluster. Singularity is a containerization framework that can be used to encapsulate applications and associated dependencies in an executable image. Images can be built from recipes (similar to Dockerfile) or can be built from an existing Docker image. In this example:

1. A docker image is built with Singularity installed within.
2. A Singularity image is build inside a running Docker container and GangSTR is installed.
3. A GangSTR test run is done within the Docker container using the newly build Singularity image.
4. Anlysis directory is copied to HPC.
5. A test run is submitted as a job on HPC.

## Step 1

Build the docker image with Singularity installed. This only needs to be run once. If you have Singularity installed on your local machine, feel free to skip this step. The recipe is contained in Dockerfile.

`./1_build_docker.sh`

## Step 2

This script launches a docker container and binds paths with the bam files, the reference and the regions files required by GangSTR. Note that you can bind paths with "rw" or "ro". Everything is bound to /home in the Docker container. Also we want to make sure to include the `--rm` flag so that the container is deleted upon exit.

`./2_launch_docker.sh`

## Step 3

Run this script from inside the newly created container. Singularity will build a .simg file from the `Singularity` recipe. THis only needs to be done once. If you already have a Singularity image, feel free to skip this step.

`./3_build_simg.sh`

## Step 4

Run this script also from inside the Docker container to test your newly created Singularity image. In this script, we mount paths into the Singularity image similar to how we mounted them into the Docker image. Only difference is that we mount to /scratch instead of /home, because the actual /home/$USER folder may be mounted to /home by Singularity by default (depending on configuration of Singularity itself). 

Make sure to change REFFA to the name of the actual reference file prior to running script.

`./4_test_in_docker.sh`

## Step 5

Exit the docker container using the `exit` command. Make sure to replace USER, HOST, SCRATCH_PATH with actual variables in the script. Then sync folder materials to HPC using `./5_sync_with_hpc.sh push`.

## Step 6

Log in to the HPC where the jobs will be submitted. Navigate to the newly created directory in scratch and submit the job to the cluster. Make sure to replace SCRATCH_PATH, PATH_TO_REF and ANALYSIS_DIR with actual variables in the script.

Make sure to change REFFA to the name of the actual reference file prior to running script.

`qsub 6_test_on_hpc.sh`