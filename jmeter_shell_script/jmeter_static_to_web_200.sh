#!/bin/bash
cd ~/Download/apache-jmeter-5.1.1/bin
rm -rf asdf.jtl
./jmeter -n -t ~/Downloads/apache-jmeter-5.1.1/object_storage/final_200.jmx -l asdf.jtl
rm -rf ~/Desktop/result
./jmeter -g asdf.jtl -f -o ~/Desktop/result
