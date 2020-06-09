#!/bin/bash

singularity exec \
    -C \
    -B home_jupyter:$HOME \
    ipycytoscape_0.2.2.sif \
    jupyter notebook --no-browser --port=8888 --ip 0.0.0.0 --notebook-dir=$HOME
