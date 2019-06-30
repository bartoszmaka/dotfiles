if application "Spotify" is running then
  tell application "Spotify"
    set theName to name of the current track
    set theArtist to artist of the current track
    set theAlbum to album of the current track
    set theUrl to spotify url of the current track
    set nameLength to the length of theName
    if nameLength > 25 then
      set theName to text 1 thru 25 of theName
      set theName to theName & ".."
    end if
    try
      return "♫  " & theArtist & " - " & theName
    on error err
    end try
  end tell
end if
