#!/bin/bash

singularity pull docker://marcodelapierre/igv:2.8.3

mkdir -p fake_home
singularity exec -B fake_home:$HOME -B ~/.Xauthority igv_2.8.3.sif igv
