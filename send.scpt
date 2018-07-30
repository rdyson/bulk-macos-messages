-- Get environment variables message and recipients
set message to system attribute "message" 
set recipients to system attribute "recipients"

-- Print the list of recipients to the console
log recipients

tell application "Messages"
    -- Get the Messages service of type iMessage
    set targetService to 1st service whose service type = iMessage

    -- For each 'recipient' in the list of recipients, set the 'buddy' item
    -- then send the text in the 'message' variable to that recipient  
    repeat with recipient in words of recipients
    	set recipient to buddy recipient of targetService
        send message to recipient
    end repeat

end tell
