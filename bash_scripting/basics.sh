#!/bin/bash

for loop
for i in $( ls ); do
    echo item: $i
done

echo

# while loop
COUNTER=0
while [ $COUNTER -lt 10 ]; do
    echo whil loop counter is $COUNTER
    let COUNTER=COUNTER+1
done

echo

# until loop
COUNTER=20
until [ $COUNTER -lt 10 ]; do
    echo untl loop COUNTER is $COUNTER
    let COUNTER-=1
done

# Using select to make simple menus
OPTIONS="Hello Quit"
select opt in $OPTIONS; do
    if [ "$opt" = "Quit" ]; then
        echo done
        exit
    elif [ "$opt" = "Hello" ]; then
        echo Hello World
    else
        clear
        echo Bad option
    fi
done

# Using the command line
if [ -z "$1" ]; then
    echo usage: $0 directory
    exit
fi

# Reading user input with read
echo Please enter your name
read NAME
echo Hi $NAME
