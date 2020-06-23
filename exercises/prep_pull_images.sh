#!/bin/bash

# session 1
singularity exec docker://quay.io/biocontainers/salmon:1.2.1--hf69c8f4_0 echo ciao
singularity exec docker://quay.io/biocontainers/fastqc:0.11.9--0 echo ciao
singularity exec docker://quay.io/biocontainers/multiqc:1.9--pyh9f0ad1d_0 echo ciao

# session 2
singularity exec docker://marcodelapierre/ggtree:2.0.4 echo ciao
singularity exec docker://marcodelapierre/ipycytoscape:0.2.2 echo ciao
singularity exec docker://marcodelapierre/igv:2.8.3 echo ciao

# session 3
singularity exec docker://rocker/tidyverse:3.6.1 echo ciao
singularity exec docker://continuumio/miniconda3:4.8.2 echo ciao
singularity exec docker://ubuntu:18.04 echo ciao
docker pull rocker/tidyverse:3.6.1
docker pull continuumio/miniconda3:4.8.2
docker pull ubuntu:18.04
