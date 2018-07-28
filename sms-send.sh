#!/bin/bash

# Watch the file named sms.txt
tail -F sms.txt | while read line; do

  # If the file has a line containing 'recipients'
  if echo "$line" | grep -q 'recipients'; then

    # Set sms.txt 'recipients' and 'message' as env vars,  Run AppleScript 
    source sms.txt
    echo "sending"
    message=$message recipients=$recipients osascript send.scpt 

    # Move sms.txt to a new file called "sent-${current_date}"
    current_date="`date +%Y%m%d%H%M`";
    mv sms.txt ${current_date}-sent.txt

    # Create a blank sms.txt file, which can be updated to send a new batch
    touch sms.txt

  fi

done

