#!/bin/bash

export SINGULARITYENV_USER=$USER
export SINGULARITYENV_PASSWORD=rstudiopassword

singularity exec \
    -C \
    -B home_rstudio:/home/rstudio -B home_rstudio:$HOME \
    ggtree_2.0.4.sif \
    rserver --www-port 8787 --www-address 0.0.0.0 --auth-none=0 --auth-pam-helper-path=pam-helper

