#! /usr/bin/bash

#You can run this script when boot machine, then you can update your DNS record in DDNS.
server="10.16.4.11" #DDNS server's IP address, in which control your domain.
host="amoners.shufangkeji.com" #Fully Qualified Domain $Name with your machine.
interface="p4p1" #Interface for  access from Internet.
ip=$(ifconfig ${interface}|grep inet|head -n 1|awk '{print $2}')
key="./ddns.key" #Directory of key file for update zone 
echo "server $server" > dns_file
echo "update add $host 600 A $ip" >> dns_file
echo "send" >> dns_file
if [ "$key" == "" ];then
    nsupdate dns_file
else
    nsupdate -k $key  dns_file 
fi
if [ "$?" == 0 ];then
    echo "add successed"
    rm dns_file
else
    echo "add failed"
fi
