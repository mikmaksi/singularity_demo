#!/bin/bash

# run this script from inside the singularity docker container
# only needs to be done once to build the .simg

image_name='gangstr-build.simg'
if [[ ! -a "$image_name" ]]; then
    # build the singularity image
    singularity build $image_name Singularity

    # change ownership of the simg
    user=$(tail -n1 /etc/passwd | cut -d':' -f1)
    chown $user $image_name
fi
