#!/bin/bash

clientid=$1

if [ "$#" -ne 1 ]; then
        echo "Error: only 1 parameter permitted"
else
    #create named pipe
    mkfifo "$clientid.pipe"

    echo "Welcome to the Client"
    echo 

    # trap ctrl-c and call ctrl_c()
    trap ctrl_c INT
    function ctrl_c() {
        #ctrl+c will remove the named pipe
        rm -f "$clientid.pipe"
        echo 
        echo "Ctrl-C by user"
        exit 0
    }

    while true; do

        echo "Enter command: "

        #casting the request into an array
        read -a "request"

        if [ ! -e server.pipe ]; then
            echo "Server is not active"
            rm -f "$clientid.pipe"
            exit 1
        elif [ "${request[0]}" == "exit" ]; then
            rm -f "$clientid.pipe"
            echo "exiting the client"
            exit 0
        elif [ "${request[0]}" == "shutdown" ]; then
            #sending the command to the server
            echo "${request[0]}" > server.pipe
            echo "server shut down"
            rm -f "$clientid.pipe"
            exit 0
        # check if the request is valid by counting the elements 
        # if the request is in the correct format but the sintax is wrong the user will be notified
        elif [ "${#request[@]}" -lt 2 ] || [ "${#request[@]}" -gt 4 ]; then
            echo
            echo "Error: the request is not in the correct format"
            exit 1
        else # if the request is correct transform in the correct format
            request="${request[0]} $clientid "
            for (( i=1; i<${#request[@]}+1; i++ ));
                do  
                    request+="${request[i]} "
                done
            echo 
            #printing the request with the clientid as second argument
            echo "your request will be sent using your ID ($clientid) as:" 
            echo "$request"
            sleep 1
            #send the request to the server
            echo "$request" > server.pipe
        fi
    
        #read the response from the server line by line
        read -d '/n' server_response < "$clientid.pipe"

        # checking how the response starts to echo successful execution 
        if [[ "$server_response" == OK:* ]] || [[ "$server_response" == Error:* ]]; then
            echo
            echo "command successfully executed"
            sleep 1
            echo "$server_response"
            echo
        #if the response begins with start_result and ends with end_result we print what is in between
        elif [[ "$server_response" == start_result* ]]; then
            echo
            echo "Result of query:"
            # sed allows to remove first and last row
            echo "$server_response" | sed '1d;$d'
            echo
        fi
    done
fi
    
