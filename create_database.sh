#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Error: missing parameter"
else 
	./P.sh "$0" #locking the script
	mkdir "$1" 2>/dev/null 
	# using the exit code to check if the operation was compelted
	if [ "$?" -eq 0 ]; then
		echo "OK: DB created"
	else
		echo "Error: DB already exists"
	fi
	./V.sh "$0" #unlocking the script
fi
