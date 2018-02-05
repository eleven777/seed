#!/bin/bash

workspace=$(cd $(dirname $0)/;pwd)
cd $workspace

mkdir -p var

pidfile=var/app.pid
logfile=var/app.log

function check(){
	if [ -f $pidfile ];then
		pid=`cat $pidfile`
		if [ -n $pid ];then
			running=`ps -p $pid|grep -v "PID TTY" |wc -l`
			return $running
		fi
	fi
	return 0
}

function start(){
	check
	running=$?
	if [ $running -gt 0 ];then
		echo -n "running, pid="
		cat $pidfile
		return 0
	fi
	nohup java -classpath "classes:@project.build.finalName@.jar" @project.groupId@.Application &> $logfile &
	sleep 1
	running=`ps -p $!|grep -v "PID TTY"|wc -l`
	if [ $running -gt 0 ];then
		echo $!>$pidfile
		echo "started, pid=$!"
	else
		echo "start failed"
	fi
}

function stop(){
	pid=`cat $pidfile`
	kill $pid
	rm -f $pidfile
	echo "stopped"
}

function restart(){
	stop
	sleep 1
	start
}

function status(){
	check
	running=$?
	if [ $running -gt 0 ];then
		echo "started"
	else
		echo "stopped"
	fi
}

function tailf(){
    tail -f $logfile
}

function help(){
	echo "start|stop|restart|status"
}
if [ "$1" == "start" ];then
    start
elif [ "$1" == "stop" ];then
	stop
elif [ "$1" == "restart" ];then
	restart
elif [ "$1" == "status" ];then
	status
elif [ "$1" == "tail" ];then
	tailf
else
	help
fi