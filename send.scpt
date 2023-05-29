on run argv
    -- Check if exactly two arguments have been passed
    if (count of argv) is not equal to 2 then
        display dialog "You must provide exactly two arguments: path to the file containing the message and path to the file containing the recipients list."
        error number -128
    end if

    -- Read the contents of the files passed as arguments
    set messageFilePath to POSIX file (item 1 of argv) as alias
    set recipientsFilePath to POSIX file (item 2 of argv) as alias

    -- Use 'read' to read the file contents into variables
    set message to read messageFilePath
    set recipientsList to read recipientsFilePath

    log message

    -- Split recipientsList into an AppleScript list by newline character
    set AppleScript's text item delimiters to ASCII character 10 -- ASCII 10 is newline
    set recipients to text items of recipientsList
    set AppleScript's text item delimiters to "" -- reset delimiters

    log recipients

    tell application "Messages"
        -- Get the Messages service of type iMessage
        set targetService to 1st service whose service type = iMessage

        -- For each 'recipient' in the list of recipients, set the 'buddy' item
        -- then send the text in the 'message' variable to that recipient
        repeat with recipient in recipients
            set recipient to buddy recipient of targetService
            send message to recipient
            delay 1
        end repeat
    end tell
end run
