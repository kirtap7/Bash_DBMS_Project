#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Error: missing parameter"
else 
    ./P.sh "$0" #locking the script
    if [ ! -d "$1" ]; then
	    echo "Error: DB does not exist"
    else
        rm -rf "$1" #removing folder and all its content
        echo "OK: DB deleted" 
    fi
    ./V.sh "$0" #unlocking the script
fi
