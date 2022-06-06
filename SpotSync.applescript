(*

This script syncronises spotify playlists to iTunes.
It does NOT download or transfer songs

Made by Jordan T. Gray. http://shinkson47.in
License : Idk man, just don't be a cunt with it, yeah?



Prequisites : 
Spofity installed
Mac with iTunes installed. Not apple music.



Usage :
- Open the playlist you're copying on spotify.

- Run script
- Script will open iTunes, and collect the titles of all songs in your library.
- When prompted, enter the name of the target playlist. If it already exsists in itunes, it will be emptied, otherwise it'll be created.

- When prompted, enter the number of songs in the spotify playlist.

- The script will configure spotify (Mute, shuffle & repeat off).
- After the final prompt, the script will wait.


- In spotify, play the first track in the playlist.


- The script will cycle through every song in the playlist, and search for a song with a matching title in your iTunes library.
  If you have a matching song in iTunes, it will be added to the iTunes playlist.

  The Spotify API hard limits the script at 100 tracks, if the script operates too fast.
  For this reason, the scripts adds a one second between each song on playlists containing
  over 100 songs. This limitation gives us the operatios at a song a second, so to process a playlist
  is (songCount / 60) minutes. But it's O(n), so it's okay lol.

- Once complete, the script will provide a list of song url's in your Spotify playlist with no
  corresponding song with a perfect matching title in your iTunes library.

  These song url's are automatically copied to the clipboard, and can be pasted into sidify to grab songs that you're missing.
*)


-----------------------------------------------------------------------------
--	Global storage
-----------------------------------------------------------------------------
set itunesLibrary to {}
set itunesNames to {}
set missingTracks to {}
set fastMode to false

-- Function to get iTunes compatable song data by name.
on getItunesSongFromName(lib, names, name)
	set i to 1
	repeat with t in names
		if t as text = name as text then
			return item i of lib
		end if
		set i to i + 1
	end repeat
	
	return null
end getItunesSongFromName



-----------------------------------------------------------------------------
-- Get data from itunes.
-----------------------------------------------------------------------------

display dialog "Learning about your iTunes library."
tell application "iTunes"
	
	-- Focus on itunes
	activate
	
	-- Get all songs from itunes
	set x to (every file track of playlist "Library")
	
	-- Store in me, not iTunes
	tell me
		set itunesLibrary to x
		
		repeat with t in itunesLibrary
			set end of itunesNames to name of t
		end repeat
	end tell
	
	-- Ask user to provide playlist name.
	set playlistName to text returned of (display dialog "Done! What's the name of the playlist we're syncing?" default answer "Test")
	
	-- Delete it, if it exists, then re-create it. Start from fresh.
	try
		delete playlist playlistName
	end try
	make new user playlist with properties {name:playlistName as text, shuffle:false, song repeat:one}
	
end tell


-----------------------------------------------------------------------------
-- Get sync playlist with spotify
-----------------------------------------------------------------------------
tell application "Spotify"
	
	-- Focus on spotify
	activate
	
	-- Get number of tracks in playlist
	set i to (text returned of (display dialog "How many songs are in the playlist?" default answer 0)) as number
	if i < 100 then
		fastMode = true
	else
		display dialog "That's over 100. Spotify will lock me out if i go through that many song fast, so i have to go slow (1 second per song). sorry."
	end if
	
	-- Tell user to get spotify ready.
	pause
	display dialog "About to commence. Click okay, i'll wait for you to play the first track of the playlist we're syncing."
	
	repeat while player state is not playing
		-- Wait for user to play
		delay 1
	end repeat
	
	-- Configure it for playing
	set shuffling to false
	set repeating to false
	set sound volume to 0
	if player state is not playing then
		playpause
	end if
	
	
	repeat with counter from 1 to i
		try
			set song to current track
			set songName to name of song
			
			
			tell me
				if itunesNames contains songName then
					log "ADDING: * " & songName
					
					-- Idk why this second tell me is needed.
					tell me to set x to getItunesSongFromName(itunesLibrary, itunesNames, songName)
					set itunesSong to x
					
					tell application "iTunes" to copy itunesSong to end of playlist playlistName
					
					--				foundBreakpoint = true
					--				log "Found breakpoint:"
					--				log songName
				else
					log "MISSING: * " & songName
					set end of missingTracks to spotify url of song
				end if
				
				tell application "Spotify"
					next track
					if not fastMode then delay 1
					set timeoutValue to 1
					repeat while songName = name of current track
						set timeoutValue to timeoutValue + 1
						if timeoutValue > 5000 then
							log "** TIMEOUT **"
							delay 5
							next track
							timeoutValue = 1
						end if
					end repeat
				end tell
				
			end tell
			
		on error msg
			log "Encountered an error whilst processing song :"
			log counter
			log "For safety, here's all the missing tracks so far : "
			log missingTracks
		end try
	end repeat
	
	log "Complete. These songs are missing from iTunes: "
	log missingTracks
	display dialog "Complete! Check messages for a list of tracks missing from iTunes"
	
end tell