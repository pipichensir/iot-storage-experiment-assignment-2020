#!/bin/bash
#test shell-script 2 for NumClient=[1,100] NumSample=100 ObjectSize=1KB

# Locate s3bench

s3bench=~/gopath/bin/s3bench

if [ -n "$GOPATH" ]; then
    s3bench=$GOPATH/bin/s3bench
fi

# minio on port 9000
# mock-s3 on port 9000
endpoint="http://127.0.0.1:9000"
# endpoint="http://127.0.0.1:9000"
bucket="loadgen"
ObjectNamePrefix="loadgen"
AccessKey="hust"
AccessSecret="hust_obs"
#filepath="minio_server_2.txt"
filepath="mock_s3_server_2.txt"

declare  -a  NumClient
declare  -a  NumSample
declare  -a  ObjectSize

NumClient=( 1    2    4    8    16   32   64   70   80   90   100)
NumSample=( 100  100  100  100  100  100  100  100  100  100  100)
ObjectSize=(1024 1024 1024 1024 1024 1024 1024 1024 1024 1024 1024)

#display run progress
progress=10

for(( i=0;i<${#NumClient[@]};i++)) 
do  
    # run sh
    $s3bench -accessKey=$AccessKey -accessSecret=$AccessSecret -bucket=$bucket -endpoint=$endpoint \
    -numClients=${NumClient[i]} -numSamples=${NumSample[i]} -objectNamePrefix=$ObjectNamePrefix -objectSize=${ObjectSize[i]} >> $filepath
     
    echo -e "=========================================================> $i/$progress done\n" >> $filepath
    echo -e "=========================================================> $i/$progress done\n"
done
