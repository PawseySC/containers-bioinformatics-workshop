#!/bin/bash

# session 1
singularity exec docker://quay.io/biocontainers/salmon:1.2.1--hf69c8f4_0 echo ciao
singularity exec docker://quay.io/biocontainers/fastqc:0.11.9--0 echo ciao
singularity exec docker://quay.io/biocontainers/multiqc:1.9--pyh9f0ad1d_0 echo ciao

# session 2

# session 3
