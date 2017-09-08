Taporwave
=========

This is just a random speed generator making an effect of unstable tape cassette player in MPV

Usage
-----

    %path_to_binary%/taporwave | mpv --input-file=/dev/stdin --audio-pitch-correction=no %your_audio_files_or_playlist%

Compilation
-----------

    ghc taporwave.hs

Known issues
------------

1) The binary is too bloated for hello world level program

1) No wowing/fluttering at this time, so the effect is not much realistic, however already able to wake up the tape nostalgia :)

1) No mplayer support

1) Reading input commands from stdin blocks operating MPV via CLI
