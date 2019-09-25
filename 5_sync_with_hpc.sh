#!/bin/bash

# copy the singularity image to a remote server that will run the code under PBS
# NOTE: make sure to replace <USER>, <HOST>, <SCRATCH_PATH> with actual variables

# options
dryrun=''
if [[ $2 && "$2" == "dry" ]]; then
	dryrun='-n'
fi

if [[ ! $1 || ! $1=="pull" || ! $1=="push" ]]; then
    echo "Neither push nor pull specified"
    exit 1
fi

# setup
analysis_dir=$(basename $(pwd))
user='<USER>'
host='<HOST>'
server="${user}@${host}"
dest_dir="${server}:<SCRATCH_PATH>/${user}/${analysis_dir}/"

# run push or pull
if [[ "$1" == "pull" ]]; then
    cmd="rsync -av --update \
	--progress ${dryrun} \
	--delete \
	--rsync-path=\"mkdir -p ${dest_dir} && rsync\" ${dryrun} \
	${dest_dir}/ $(pwd)/"
fi

if [[ "$1" == "push" ]]; then
    cmd="rsync -av --update \
	--progress ${dryrun} \
	--delete \
	--rsync-path=\"mkdir -p ${dest_dir} && rsync\" ${dryrun} \
	$(pwd)/ ${dest_dir}/"
fi

echo $cmd
eval $cmd
