Taporwave
=========

This is just a random speed generator making an effect of unstable tape cassette player in MPV

Usage
-----

    %path_to_binary%/taporwave | mpv --input-file=/dev/stdin --audio-pitch-correction=no %your_audio_files_or_playlist%

You may also pass parameters `--minBound` and `--maxBound` to taporwave if default bounds (0.8 and 1.2 of original speed respectively) do not satisfy you.

Compilation
-----------

    make

This would install dependencies if needed, compile the program and compress it with UPX if it is installed.

Known issues
------------

1) The binary is too bloated for hello world level program

1) No wowing/fluttering at this time, so the effect is not much realistic, however already able to wake up the tape nostalgia :)

1) No mplayer support

1) Reading input commands from stdin blocks operating MPV via CLI
