FROM python:3.7-buster as builder

MAINTAINER Takeshi Kishiyama <kishiyama.t@gmail.com>

# Setting & Copy
WORKDIR /opt/app
COPY requirements.lock /opt/app

# Env
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -yq ssh git curl apt-utils && \
    apt-get install -yq gcc g++

# Libraries
RUN pip install -r requirements.lock

# Experiment
RUN git clone https://github.com/ry-takashima/python_asr.git

RUN apt-get install -yq sox

# Fetch data
RUN cd python_asr/00prepare && python 00download_data.py
RUN cd python_asr/00prepare && python 01prepare_wav.py
RUN cd python_asr/00prepare && python 02prepare_label.py
RUN cd python_asr/00prepare && python 03subset_data.py
# RUN cd python_asr/00prepare && python /00download_data.py

