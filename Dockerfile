FROM ubuntu:focal

LABEL maintainer="pricea35@cardiff.ac.uk" \
software="ls-bsr extract_core_genome.py" \
software.version="1.0.3" \
about.summary="Image for the extract_core_geonme.py script from ls-bsr" \
about.home="https://github.com/jasonsahl/LS-BSR"

ENV PACKAGES="curl wget vim git build-essential ncbi-blast+"

ENV PYTHON="python3 python3-pip"

ENV PYTHON_PACKAGES="biopython"

RUN apt-get update \
&& apt-get install -y $PACKAGES $PYTHON \
&& pip3 install --no-cache-dir $PYTHON_PACKAGES \
&& wget https://raw.githubusercontent.com/jasonsahl/LS-BSR/master/tools/extract_core_genome.py \
&& sed -i 's:#!/usr/bin/env python:#!/usr/bin/env python3:g' extract_core_genome.py \
&& chmod +x extract_core_genome.py \
&& mv extract_core_genome.py /usr/local/bin

RUN git clone https://github.com/rcedgar/muscle.git \
&& make -C muscle/src

ENV PATH ${PATH}:/muscle/src/Linux
