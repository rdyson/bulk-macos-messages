#!/bin/bash

# Watch the file named sms.txt; add a custom directory (like Dropbox or Files) to reference a file outside of the current directory.
directory=.
tail -F ${directory}/sms.txt | while read line; do

  # If the file has a line containing 'recipients'
  if echo "$line" | grep -q 'recipients'; then

    # Set sms.txt 'recipients' and 'message' as env vars,  Run AppleScript 
    source ${directory}/sms.txt
    echo "sending"
    message=$message recipients=$recipients osascript send.scpt 

    # Move sms.txt to a new file called "sent-${current_date}.txt"
    current_date="`date +%Y%m%d%H%M`";
    mv ${directory}/sms.txt ${directory}/${current_date}-sent.txt

    # Create a blank sms.txt file, which can be updated to send a new batch
    touch ${directory}/sms.txt

  fi

done

