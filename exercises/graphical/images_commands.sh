#!/bin/bash

# rstudio
# image:  docker://marcodelapierre/ggtree:2.0.4
# command:  rserver --www-port 8787 --www-address 0.0.0.0 --auth-none=0 --auth-pam-helper-path=pam-helper

# jupyter
# image:  docker://marcodelapierre/ipycytoscape:0.2.2
# command:  jupyter notebook --no-browser --port=8888 --ip 0.0.0.0 --notebook-dir=$HOME

# igv
# image:  docker://marcodelapierre/igv:2.8.3
# location:  chr4:39,348,243-39,348,635  [gene RFC1]
