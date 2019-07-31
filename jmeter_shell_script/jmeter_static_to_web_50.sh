#!/bin/bash
cd ~/object_storage
aws --endpoint-url=http://kr.object.ncloudstorage.com s3 sync s3://bucket-asset .
cd ~/apache-jmeter-5.1.1/bin
rm -rf asdf.jtl
./jmeter -n -t ~/object_storage/final_50.jmx -l asdf.jtl
rm -rf /usr/share/nginx/html/result
./jmeter -g asdf.jtl -f -o /usr/share/nginx/html/result
