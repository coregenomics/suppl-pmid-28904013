#!/usr/bin/env bash

set -e

dir_downloads=downloads
img=R-3.3.0.simg

# Check how much local disk space we have.
df -Ph .

# Download the supplementary code and data.
mkdir -p ${dir_downloads}
wget \
    --no-clobber \
    --directory-prefix=${dir_downloads} \
    https://genome.cshlp.org/content/suppl/2017/09/13/gr.226035.117.DC1/Supplemental_Code.zip

# Fetch R 3.3.0 from singularity-hub.
if ! [[ -f $dir_downloads/$img ]]; then
    cd downloads
    singularity pull --name $img shub://coregenomics/r-3.3.0-debian-7
    cd -
fi

R () {
    $dir_downloads/$img --quiet --no-save --no-environ $@
}

# Download the GEO data.
R <<EOF
options(echo = TRUE)
if (! require(BiocInstaller, quietly = FALSE))
    source("https://bioconductor.org/biocLite.R")
if (! require(GEOquery, quietly = FALSE))
    BiocInstaller::biocLite("GEOquery")
GEOquery::getGEOfile('GSE98420', destdir = '${dir_downloads}')
EOF
