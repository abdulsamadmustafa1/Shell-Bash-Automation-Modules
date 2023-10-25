#!/bin/bash

# default value to use if none specified
PERCENT=50

# test for command line arguement is present
if [[ $# -le 0 ]]   # if $# is something which stores the previous command output, -le means less than ge greater than   
then
    printf "There are no disks running with more usage than= %d\n" $PERCENT
# test if argument is an integer
# if it is, use that as percent, if not use default
else
    if [[ $1 =~ ^-?[0-9]+([0-9]+)?$ ]] # regex pattern 
    then
        PERCENT=$1
#	printf "The disk running = "$PERCENT "\n\n"
    fi
fi

let "PERCENT += 0"
printf "Threshold = %d\n" $PERCENT

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1 }' | while read data; # ^ this is regex comparision command -vE is an argument, while is while loop in linux 
do
    used=$(echo $data | awk '{print $1}' | sed s/%//g)  # sed command manupulate variables s is subtitute g is global it means whatever data is comming replace it with no space
    p=$(echo $data | awk '{print $2}')
    if [ $used -ge $PERCENT ]
    then
        echo "WARNING:The partition \" $p\" has used $used% of total available space - Date: $(date)"
    fi
done
