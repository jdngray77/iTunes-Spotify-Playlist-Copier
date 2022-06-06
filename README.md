# iTunes Spotify Playlist Copier

An Applescript which re-creates Spotify playlists within iTunes.

This script does NOT download or transfer songs, it just creates playlists
with the same songs.

Though it does not download the songs, it does provide a list of
all songs that aren't in your iTunes Library, which can be pasted
directly into [Sidify Music Converter](https://www.sidify.com/en1/)
to download them.

## Requirements : 

 - Mac OS
 - iTunes installed ; **not Apple Music**
 - Spotify installed

# Usage : 
- On spotify, open the playlist you wish to copy.

- Open the script, and click run.  
  iTunes will open, and the script will collect the titles of in your library.
  
- Enter the name of the playlist. 
  Note that if it already exsists in itunes, it will be emptied.

- Enter the number of songs in the spotify playlist.
  This is displayed in spotify.
  
  The script will configure spotify (Mute, shuffle & repeat off), 
  then it will wait for spotify to begin playing.

- In spotify, double check that shuffle is off.
- In spotify, play the first track in the playlist.

  The script will cycle through every song in the playlist, and search for a song with a matching title in your iTunes library.
  If you have a matching song in iTunes, it will be added to the iTunes playlist.
  
- Once complete, the script will provide a list of URL's to songs that were missing in your iTunes library.
  These song url's are automatically copied to the clipboard, and can be pasted into sidify to grab songs that you're missing.

# Speed limit
  The Spotify API hard limits the script at 100 tracks, if the script operates too fast.
  
  For this reason, the scripts adds a one second delay between skipping songs 
  on playlists containing over 100 songs. 
