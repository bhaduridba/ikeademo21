#!/usr/bin/env bash
## use pip to install required libraries
## ************************************************* ##
## ************************************************* ##

# 1. setup gcloud in your local laptop or in a cloud vm 
#    gcloud components update
# Setup environment
# create a service account in DSM project for Locker
# I have create a service account sa-dsm-ikeademo2-sb1
# create key and use it for the script

### KEEP THE KEY CONFIDENTIAL ###
export GOOGLE_APPLICATION_CREDENTIALS="/Users/sobhan/Documents/projects/ikeademo20/sa-dsm-ikeademo2-sb2.json"
# gcloud auth login

pip install -r requirements.txt

export REGION=us-central1
#export REGION=eu-north1
#echo $REGION
# git clone https://github.com/bhaduridba/ikeademo20.git .
# cd ikeademo20

## Create streaming source and destination sinks
## Create the Cloud Storage bucket

## Source is PROJECT 1 and PROJECT 2 is our DSM
#export PROJECT_ID2='ingka-advanced-analytics-dev'

## To test in my setup
export PROJECT_ID2='ikeademo2-sb2'
#echo $PROJECT_ID2
gcloud config set project $PROJECT_ID2

## 2
# create bucket to write the streaming events 
export SOURCE='cleveron'
export TARGET='dsm'
export CLEVERON_SOURCE_OUTPUT=${SOURCE}_${TARGET}_source
#echo $CLEVERON_SOURCE_OUTPUT

# gs://cleveron-dsm-input-files
gsutil mb -c regional -l ${REGION} gs://${CLEVERON_SOURCE_OUTPUT}

##3
# create bigquery dataset
export BQ_DEMO_DATASET4='jsondemo4'

bq --location='US' mk -d \
--default_table_expiration 7200 \
--description "This is a JSON demo 4 temporary dataset." \
${BQ_DEMO_DATASET4}

# create table
export BQ_DEMO_TABLE3='demo4'

bq mk \
  --table \
  --expiration 7200 \
  --description "This is a demo temporary table demo 4" \
  --label organization:development \
  ${BQ_DEMO_DATASET4}.${BQ_DEMO_TABLE4} \
  jsondemo2schema.json

exit
