#!/bin/bash
# Native messaging host wrapper for addImage.sh

# Read input from Chrome
read -r input

# Optional logging
echo "$(date): $input" >> /tmp/addImageHost.log

# Launch your existing addImage.sh
/home/owen/bin/addImage.sh
