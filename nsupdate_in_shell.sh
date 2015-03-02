#! /usr/bin/bash

if [[ "$1" == "" ]];then
    echo "Usage: nsupdate_in_shell.sh server option host ip"
    exit 1
fi
server=$1
option=$2
host=$3
ip=$4
echo "server $server" > dns_file
if [ "$option" == 'add' ];then
    echo "update $option $host 600 A $ip" >> dns_file
else
    echo "update $option $host A" >> dns_file
fi
echo "send" >> dns_file
if [ -e ./ddns.key ];then
    nsupdate -k ./ddns.key dns_file
else
    nsupdate dns_file
fi
if [ "$?" == 0 ];then
    echo "$option successed"
    rm dns_file
    echo "update $option $host 600 A $ip" >> ./dns_update_log
else
    echo "$option failed"
fi
