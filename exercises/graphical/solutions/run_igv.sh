#!/bin/bash

singularity exec \
    -B home_igv:$HOME \
    -B ~/.Xauthority \
    igv_2.8.3.sif igv

