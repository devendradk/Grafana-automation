#!/bin/bash
echo 'Juniper123' | sudo -S service grafana-server restart
echo "##Flushing influxDB..."
influx -execute "use Juniper"
influx -execute "DROP DATABASE Juniper"
influx -execute "show databases"
sleep 3
./createjson.sh
sleep 2
rm -rf nohup.out
echo "Killing old sessions..."
echo 'Juniper123' | sudo -S kill -9 $(ps -aux | grep .json | grep sudo | awk {'print $2'})
sleep 1
echo 'Juniper123' | sudo -S kill -9 $(ps -aux | grep .json | grep sudo | awk {'print $2'}i)
sleep 1
echo 'Juniper123' | sudo -S kill -9 $(ps -aux | grep ./grpc-telemetry-client | awk {'print $2'})
sleep 1
echo 'Juniper123' | sudo -S kill -9 $(ps -aux | grep ./grpc-telemetry-client | awk {'print $2'})
sleep 1
echo 'Juniper123' | sudo -S kill -9 $(ps -aux | grep retry.sh | awk {'print $2'})
sleep 1
echo 'Juniper123' | sudo -S kill -9 $(ps -aux | grep retry.sh | awk {'print $2'})
while read host
do
echo "Spawning host $host.."
echo 'Juniper123' | sudo -S nohup ./grpc-telemetry-client --config $host.json &
done < hosts.txt
#echo "Spawning retry script..."
#echo 'Juniper123' | sudo -S nohup ./retry.sh &
