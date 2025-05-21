#!/bin/bash

# Sample bash script with common issues for testing MDC rules

# No error handling
cd /some/directory

# Using unsafe variable expansion
echo "Processing file: $file"

# Not quoting variables
files=$(ls *.txt)
for file in $files; do
    echo Processing $file
done

# Command without checking exit code
rm -rf /tmp/test-dir

# Hardcoded paths
log_file="/var/log/app.log"

# Function without local variables
function process_data() {
    result="Processed data"
    echo $result
}

# No input validation
user_input=$1
echo "User provided: $user_input"

# Using deprecated syntax
function cleanup {
    echo "Cleaning up..."
}

# Piping to commands without error checking
cat file.txt | grep "pattern"