FROM python:3.7.3-buster as builder

MAINTAINER Takeshi Kishiyama <kishiyama.t@gmail.com>

# Setting & Copy
WORKDIR /opt/app
COPY requirements.lock /opt/app

# Env
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -yq ssh git curl apt-utils && \
    apt-get install -yq gcc g++ && \
    apt-get install -y r-base

# Libraries
RUN pip install -r requirements.lock

RUN R -e "install.packages('tidyverse', repos = 'http://cran.us.r-project.org')"
# Experiment
RUN git clone https://github.com/kishiyamat/python-asr.git
