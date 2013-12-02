#!/usr/bin/env bash

/usr/local/etc/rc.d/rabbitmq status | grep "\[{pid"
pid_found="$?"

if [ "$pid_found" == "0" ]; then
    #PID is available in the status message
    rabbitmqpid=`/usr/local/etc/rc.d/rabbitmq status | grep "\[{pid" | sed "s/.*,\(.*\)\}.*/\1/"`
else
    #PID should be available from file
    rabbitmqpid=`sed "s/.*,\(.*\)\}.*/\1/" /var/lib/rabbitmq/pids`
fi

echo "RabbitMQ PID: $rabbitmqpid"
echo "$rabbitmqpid" > /var/run/rabbitmq.pid
