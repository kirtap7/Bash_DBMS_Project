#!/bin/bash

#creating the named pipe
mkfifo server.pipe

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
function ctrl_c() {
    rm -f server.pipe
    echo 
    echo "Ctrl-C by user"
    exit 0
}

while true; do
    echo "Server waiting for instruction"

    #read the input and cast it into an array
    read -a input < server.pipe 
    #split the arrays and assign variables
    command="${input[0]}"
    clientid="${input[1]}"
    database="${input[2]}"
    table="${input[3]}"
    columns="${input[4]}"

    case "$command" in
        "create_database")
            echo "creating database"
            ./create_database.sh $database > "$clientid.pipe" & sleep 1
            ;;
        "create_table")
            echo "creating table"
            ./create_table.sh $database $table $columns > "$clientid.pipe" & sleep 1
            ;;
        "insert")
            echo "inserting data"
            ./insert.sh $database $table $columns > "$clientid.pipe" & sleep 1
            ;;
        "select")
            echo "selecting results"
            ./query.sh $database $table $columns > "$clientid.pipe" & sleep 1
            ;;
        "delete_database")
            echo "deleting database"
            ./delete_database.sh $database > "$clientid.pipe" & sleep 1
            ;;
        "delete_table")
            echo "deleting table"
            ./delete_table.sh $database $table > "$clientid.pipe" & sleep 1
            ;;
        "shutdown")
            echo "server shut down"
            rm -f server.pipe
            exit 0
            ;;
        *) #if the command is not permitted echo an error message
            echo "Error: bad request"
            echo "Error: bad request" > "$clientid.pipe"
    esac
done