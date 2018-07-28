set message to system attribute "message" 
set recipients to system attribute "recipients"
-- on run {targetBuddyPhone, targetMessage}
log recipients

tell application "Messages"
    set targetService to 1st service whose service type = iMessage

    repeat with recipient in words of recipients
    	set recipient to buddy recipient of targetService
        send message to recipient
    end repeat

end tell
end run
