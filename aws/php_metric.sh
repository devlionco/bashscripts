#!/bin/bash

AWS_DEFAULT_REGION="eu-west-1"
#AWS_ACCESS_KEY_ID=""
#AWS_SECRET_ACCESS_KEY=""

INSTANCE_ID_URL="http://169.254.169.254/latest/meta-data/instance-id"
INSTANCE_ID=$(curl -s ${INSTANCE_ID_URL})

SERVER_STATUS_URL="http://localhost:82/php_fpm_statusz"
SERVER_STATUS_HOSTNAME="localhost"

NAMESPACE="php-fpm"
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

TMP_FILE="/tmp/php-fpm-status"

# GET /php-fpm-status
curl -H"Host: ${SERVER_STATUS_HOSTNAME}" \
-s -L ${SERVER_STATUS_URL} > ${TMP_FILE}

# put-metric-data
${PUT_METRIC_CMD} --metric-name IdleProcesses --unit Count \
--value $(grep -e '^idle processes' ${TMP_FILE} | awk -F: '{printf "%i", $2}')

${PUT_METRIC_CMD} --metric-name ActiveProcesses --unit Count \
--value $(grep -e '^active processes' ${TMP_FILE} | awk -F: '{printf "%i", $2}')

${PUT_METRIC_CMD} --metric-name TotalProcesses --unit Count \
--value $(grep -e '^total processes' ${TMP_FILE} | awk -F: '{printf "%i", $2}')

${PUT_METRIC_CMD} --metric-name MaxActiveProcesses --unit Count \
--value $(grep -e '^max active processes' ${TMP_FILE} | awk -F: '{printf "%i", $2}')

${PUT_METRIC_CMD} --metric-name MaxChildrenReached --unit Count \
--value $(grep -e '^max children reached' ${TMP_FILE} | awk -F: '{printf "%i", $2}')

${PUT_METRIC_CMD} --metric-name SlowRequests --unit Count \
--value $(grep -e '^slow requests' ${TMP_FILE} | awk -F: '{printf "%i", $2}')
