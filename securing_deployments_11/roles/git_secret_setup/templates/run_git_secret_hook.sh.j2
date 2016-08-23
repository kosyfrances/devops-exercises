#!/bin/bash

# Check if target directory is supplied as an argument when running script
if [ "$#" -eq 0 ]; then
    echo "No target directory supplied as argument when running the script."
    echo "Exiting script."
    exit 1
else
    # Check if target directory exist
    if [ -d "$1" ]; then
        echo "Moving to $1"
        cd "$1"

        echo "Installing git-secrets hooks in $1"
        git secrets --install -f

        echo "Adding hooks for aws"
        git secrets --register-aws
    else
        echo "Target directory does not exist."
        exit 1
    fi
fi
