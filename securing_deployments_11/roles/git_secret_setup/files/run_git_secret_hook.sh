#!/bin/bash

# fail and fail fast \0/
set -e

# Check if target directory is supplied as an argument when running script
if [ "$#" -eq 0 ]; then
    echo "No target directory supplied as argument when running the script."
    echo "Exiting script."
    exit 1
else
    REPOSITORY=$1
    # Check if target directory exist
    if [ -d "$REPOSITORY" ]; then
        echo "Moving to $REPOSITORY"
        cd "$REPOSITORY"

        echo "Installing git-secrets hooks in $REPOSITORY"
        git secrets --install -f

        echo "Adding hooks for aws"
        git secrets --register-aws
    else
        echo "Target directory does not exist."
        exit 1
    fi
fi
