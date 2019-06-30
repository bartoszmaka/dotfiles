tell application "Reminders"
	set num to (count of (reminders in list "Reminders" whose completed is false))
	return num
end tell

