# iTunes Spotify Playlist Copier

An Applescript which re-creates Spotify playlists within iTunes.

**This script does NOT download or transfer songs, it creates playlists in iTunes with songs
that are already in your library.**

Although it does not download the songs, it does provide a list of
all songs that aren't in your iTunes Library, which can be pasted
directly into [Sidify Music Converter](https://www.sidify.com/en1/)
to download them so you can complete the playlist.

## Requirements : 

 - Mac OS
   (Tested on Sierra and High Sierra only)
   
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
  
- Once complete, the script will provide a list of URI's to songs that were missing in your iTunes library.
  These can be pasted into sidify to grab songs that you're missing.

## Speed limit
  The Spotify API hard limits the script at 100 tracks, if the script operates too fast.
  
  For this reason, the scripts adds a one second delay between skipping songs 
  on playlists containing over 100 songs. 
  
  ## Example uses :
  


https://user-images.githubusercontent.com/50697488/172217400-22b7d94f-4428-47b4-a630-be8f6f5153a0.mov



https://user-images.githubusercontent.com/50697488/172218003-b33812a5-173c-4fca-9c26-782a553ae4ae.mov




  
  
  ## Sample log
  ![Screen Shot 2022-06-06 at 18 46 39](https://user-images.githubusercontent.com/50697488/172216593-e2592b39-8b35-4fb5-85b5-f813d04c2374.png)
  
