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

# OTHERWISE YOU CAN USE YOUR EMAIL 
# gcloud auth login

pip install -r requirements.txt

export REGION=us-central1
#echo $REGION

#export PROJECT_ID1='ingka-dsm-dataplatform-dev'
#echo $PROJECT_ID1
## For testing in my env
export PROJECT_ID1='ikeademo1-sb1'

#export PROJECT_ID2='ingka-advanced-analytics-dev'
#echo $PROJECT_ID2

## For testing in my env
export PROJECT_ID2='ikeademo2-sb2'
#echo $PROJECT_ID2
gcloud config set project $PROJECT_ID2

export SOURCE='cleveron'
export TARGET='dsm'

export STREAMING_TOPIC=${PROJECT_ID1}-${SOURCE}-streaming-topic1

export CLEVERON_SOURCE_OUTPUT=${SOURCE}_${TARGET}_source
#echo $CLEVERON_SOURCE_OUTPUT

export BQ_DEMO_DATASET3='jsondemo4'
#echo $BQ_DEMO_DATASET3
export BQ_DEMO_TABLE3='demo4'
#echo $BQ_DEMO_TABLE3

export DataflowJobName2='CLEVERON_DSM_LOCKER_job_2'
export MaxWokers=3
export NumWorkers=2

gcloud dataflow jobs run $DataflowJobName2   \
     --gcs-location gs://dataflow-templates-us-central1/latest/PubSub_Subscription_to_BigQuery   \
     --region $REGION  \
     --max-workers $MaxWokers  \
     --num-workers $NumWorkers  \
     --service-account-email sa-dsm@ikeademo2-sb1.iam.gserviceaccount.com  \
     --staging-location gs://${CLEVERON_SOURCE_OUTPUT}/temp  \
     --parameters inputSubscription=projects/${PROJECT_ID1}/subscriptions/sub2-${STREAMING_TOPIC},outputTableSpec=${PROJECT_ID2}:${BQ_DEMO_DATASET4}.${BQ_DEMO_TABLE4}

exit



