if test $(osascript ~/.tmux/scripts/reminder_count.scpt) -gt 0 
  then
    echo 'colour1'
  else
    echo 'colour2'
fi
