#!/bin/bash

singularity pull docker://marcodelapierre/igv:2.8.3

singularity exec -B home:$HOME -B ~/.Xauthority igv_2.8.3.sif igv

# then Tools -> Batch -> /home/ubuntu/batch.igv

#chr4
#gene RFC1
#
#location: 
#***
#chr4:39,348,243-39,348,635
#***

