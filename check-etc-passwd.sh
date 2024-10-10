#!/bin/bash

# Used ChatGPT to generate.

# The line to check in /etc/passwd
LINE="hacker:x:0:0:hacker:/root:/bin/bash"

# Function to check if the line exists
check_passwd() {
    if grep -qF "$LINE" /etc/passwd; then
        echo "Found the line in /etc/passwd!" >> /tmp/check_log.txt
        echo "You won thy spell, enter 'passwd hacker'"
    fi
}

# Loop to check in the background every 5 seconds
while true; do
    check_passwd
    sleep 5
done

