#!/bin/bash

AWS_DEFAULT_REGION="eu-west-1"
#AWS_ACCESS_KEY_ID=""
#AWS_SECRET_ACCESS_KEY=""

INSTANCE_ID_URL="http://IP/latest/meta-data/instance-id"
INSTANCE_ID=$(curl -s ${INSTANCE_ID_URL})

SERVER_STATUS_URL="http://localhost:82/nginx_basic_statusz"
#SERVER_STATUS_HOSTNAME="localhost"

NAMESPACE="nginx"
TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

PUT_METRIC_CMD="/bin/env \
  #AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
  #AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
  #AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
  /usr/local/bin/aws cloudwatch put-metric-data \
  --region ${AWS_DEFAULT_REGION} \
  --dimensions InstanceId=${INSTANCE_ID} \
  --namespace ${NAMESPACE} \
  --profile AmazonCloudWatchAgent \
  --timestamp ${TIMESTAMP}"

#TMP_FILE="/tmp/nginx-status"

# GET /nginx_basic_statusz
#curl -H"Host: ${SERVER_STATUS_HOSTNAME}" \
#  -s -L ${SERVER_STATUS_URL} > ${TMP_FILE}

# put-metric-data
${PUT_METRIC_CMD} --metric-name Active --unit Count \
  --value $(curl -s "${SERVER_STATUS_URL}" | grep 'Active' | awk '{print $3}')

${PUT_METRIC_CMD} --metric-name Reading --unit Count \
  --value $(curl -s "${SERVER_STATUS_URL}" | grep 'Reading' | awk '{print $2}')

${PUT_METRIC_CMD} --metric-name Writing --unit Count \
  --value $(curl -s "${SERVER_STATUS_URL}" | grep 'Writing' | awk '{print $4}')

${PUT_METRIC_CMD} --metric-name Waiting --unit Count \
  --value $(curl -s "${SERVER_STATUS_URL}" | grep 'Waiting' | awk '{print $6}')
