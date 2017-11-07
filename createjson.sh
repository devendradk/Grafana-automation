#!/bin/bash
echo "Creating JSON config files..."
while read host;
do
eval $(echo -e  "sed 's/DUT/$host/g' temp.json > $host.json")
done < hosts.txt
echo "Done..."
