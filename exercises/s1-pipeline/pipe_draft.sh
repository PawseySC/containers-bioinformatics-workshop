#!/bin/bash

salmon index -t ggal_1_48850000_49020000.Ggal71.500bpflank.fa -i index

salmon quant --libType=U -i index -1 ggal_gut_1.fq -2 ggal_gut_2.fq -o ggal_gut

mkdir fastqc_logs
fastqc -o fastqc_logs -f fastq -q ggal_gut_1.fq ggal_gut_2.fq

mkdir multiqc_logs
cd multiqc_logs
# not sure here
ln -s ../ggal_gut .
ln -s ../fastqc_logs .
multiqc -v .
