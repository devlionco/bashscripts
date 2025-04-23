<?php

require 'vendor/autoload.php';

use Aws\CloudWatch\CloudWatchClient;
use Aws\Exception\AwsException;

function putMetricData($cloudWatchClient, $cloudWatchRegion, $namespace,
                       $metricData)
{
    try {
        $result = $cloudWatchClient->putMetricData([
            'Namespace' => $namespace,
            'MetricData' => $metricData
        ]);

        if (isset($result['@metadata']['effectiveUri']))
        {
            if ($result['@metadata']['effectiveUri'] ==
                'https://monitoring.' . $cloudWatchRegion . '.amazonaws.com')
            {
                return 'Successfully published datapoint(s).'.PHP_EOL;
            } else {
                return 'Could not publish datapoint(s).';
            }
        } else {
            return 'Error: Could not publish datapoint(s).';
        }
    } catch (AwsException $e) {
        return 'Error: ' . $e->getAwsErrorMessage();
    }
}

function putTheMetricData()
{
    $namespace = 'PETEL';
$value = rand(3,10);
echo $value.PHP_EOL;
$metricData = [
[
'MetricName' => 'ConcurrentUsers',
'Timestamp' => time(), //1647683650, // 19 March 2022, 20:26:58 UTC.

'Dimensions' => [
[
'Name' => 'STGroup',
'Value' => 'Physics'

]
/*
[
'Name' => 'Chemistry',
'Value' => '23'
]
*/
],
'Unit' => 'Count',
'Value' => $value
],
[
'MetricName' => 'ConcurrentSessions',
'Timestamp' => time(), //1647683650, // 19 March 2022, 20:26:58 UTC.

'Dimensions' => [
[
'Name' => 'STGroup',
'Value' => 'Physics'

]
/*
[
'Name' => 'Chemistry',
'Value' => '23'
]
*/
],
'Unit' => 'Count',
'Value' => $value+2
]
];

$cloudWatchRegion = 'eu-west-1';
$cloudWatchClient = new CloudWatchClient([
//'profile' => 'default',
'profile' => 'AmazonCloudWatchAgent',
'region' => $cloudWatchRegion,
'version' => '2010-08-01'
]);

echo putMetricData($cloudWatchClient, $cloudWatchRegion, $namespace,
$metricData);
}

// Uncomment the following line to run this code in an AWS account.
putTheMetricData();
echo time().PHP_EOL;
