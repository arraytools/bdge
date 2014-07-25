#!/bin/bash
#
# Installation script for RNA-Seq data preprocessing
# 
# Note that there is a dependency issue. So getting the latest version may not work. 
# For example, tophat v2.0.11 only supports bowtie2 v2.2.1 but not v2.2.2.

SRATOOLKIT_URL=http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.3.5-2/sratoolkit.2.3.5-2-ubuntu64.tar.gz
BOWTIE2_URL=http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.1/bowtie2-2.2.1-linux-x86_64.zip/download
TOPHAT_URL=http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.11.Linux_x86_64.tar.gz
SAMTOOLS_URL=http://sourceforge.net/projects/samtools/files/samtools/0.1.19/samtools-0.1.19.tar.bz2/download
HTSEQ_URL=https://pypi.python.org/packages/source/H/HTSeq/HTSeq-0.6.1.tar.gz#md5=b7f4f38a9f4278b9b7f948d1efbc1f05
FASTQC_URL=http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.10.1.zip
FASTX_URL=http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2

set -e

# create a new directory; /tmp/pp20140729
NOW=$(date +"%Y%m%d")
OUTDIR=/tmp/pp$NOW

if [ ! -d OUTDIR ]; then
  mkdir -p OUTDIR
fi
cd OUTDIR

# sratoolkit
wget -N $SRATOOLKIT_URL -O sratoolkit.tar.gz
tar xzvf sratoolkit.tar.gz

# bowtie
if [ -f bowtie2.zip ]; then
  rm bowtie2.zip
fi
wget $BOWTIE2_URL -O bowtie2.zip
unzip -o bowtie2.zip

# tophat
wget -N $TOPHAT_URL -O tophat.tar.gz
tar xzvf tophat.tar.gz

# samtools (needs to compile)
wget $SAMTOOLS_URL -O samtools.tar.bz2
tar xjvf samtools.tar.bz2

# htseq-count (needs to compile)
wget -N $HTSEQ_URL -O HTSeq.tar.gz
tar xzvf HTSeq.tar.gz

# fastqc
if [ -f fastqc.zip ]; then
  rm fastqc.zip
fi
wget -N $FASTQC_URL -O fastqc.zip
unzip -o fastqc.zip

# fastx
wget $FASTX_URL -O fastx.tar.bz2
if [ ! -d fastx ]; then
mkdir fastx
fi
tar -xjvf fastx.tar.bz2 -C fastx

# clean up
rm *.zip *.tar.gz *.tar.bz2

echo finish_install_rnaseq > /tmp/install.log

