# Bulk macOS Messages

It's not currently possible on iOS or macOS to send an SMS message or Apple Message to multiple people individually (as opposed to a group) without creating a new message for each person. This script automates that process on macOS.

## How it works

`send.scpt` is an AppleScript that reads environment variables `recipients` and `message`. It then loops over the list of recipients and tells the Messages app to send the message to each recipient. After looping over the list it renames `sms.txt` to `sms-${current_date}.txt` and creates a blank `sms.txt`.

`sms.txt` is where the `recipients` phone numbers and the `message` text are defined.

`send.sh` starts a `tail` process that watches `sms.txt` for changes. If there is text in the file, it attempts to set environment variables for `recipients` and `message`, and then starts the `send.scpt` AppleScript. 

## Pre-requisites

* A computer running macOS and an iCloud an account. Tested on macOS 10.13 High Sierra.
* Enable [SMS Forwarding](https://support.apple.com/en-us/HT204681#SMS)  if you want to send to non-iOS recipients.


## Setup

1. Clone this repository and replace the contents of `sms.txt` with your recipients list and message text.
1. Update `send.sh` line 4 with the directory where your `sms.txt` file will live. For example, you can point to a Dropbox folder to facilitate triggering a send from your phone or any computer by editing this file.
1. Make the script executable by running `chmod +x send.sh`.
1. Run `./send.sh` in a Terminal window. 
1. Verify that the messages were sent by checking the Messages app on your Mac or on an iOS device.

## Notes

* If you want to send a group of messages but don't have the need for triggering a send remotely, or if you're not going to be using the script regularly, you can simply pass environment variables directly into the AppleScript by running `recipients="12345678901 11098765432" message="message here" osascript send.scpt`. This sets the variables for `recipients` and `message` directly, as opposed to reading them in from the `sms.txt` file. `send.sh` is not needed if you're using this method.
* This AppleScript will only send to recipients with whom you have an existing conversation in Messages.
* SMS has a limit of 160 characters, whereas Messages can handle ~20k characters. This script does not enforce character limits.
* The `message` can't contain straight double quotes (" ")—use curly quotes instead (“ ”). Other special characters may cause issues.
* If sending to one recipient fails, the script will exit. Be sure to remove recipients who have been sent the message successfully before running the script again, to avoid sending duplicate messages.

## References

* https://alvinalexander.com/apple/applescript-for-loop-while-loop-examples
* https://hints.macworld.com/article.php?story=20050523140439734
* https://stackoverflow.com/questions/9574089/osx-bash-watch-command