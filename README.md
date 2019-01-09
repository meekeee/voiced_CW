# Train to learn Morse by "beeps" and voice cues!

I am learning CW and "mind copying" does not yet come easy to me. In order to
exercise and train, I created a simple bash script (under macOs) to
generate single mp3 audio files containing random Morse characters followed by
an audio cue, spoken by a synthetic voice. In this way, I can immediately test
whether or not I decoded the Morse sounds correctly.

I am grateful to the Reddit user /u/Km6jur for the inspiration: he manually
stitched together individual audio files (generated by specific websites) for
the very same purpose. The idea behind my project instead is to avoid
laborious procedures and make the entire process automated and fast.  In
principle, one could quickly create a series of training files to listen while
commuting, driving, walking.

This works as a bash script, under macOs. If you are knowledgeable with the
command line and with scripting, you should be able to port it to any
other OS.

Three steps are required: (1) generating voice cues, (2) generating CW audio
files, and (3) stitching everything together in the right sequence.  On macOs,
I found how to take care of (1) and programmatically generate individual mp3
files for the synthetic voice cues (i.e. by the system command "say"). Perhaps
[http://espeak.sourceforge.net] might be a good replacement if you are on
Windows or Linux. For (2), I installed ebook2cw
([https://fkurz.net/ham/ebook2cw.html]) and placed its executable in the very
same working folder of my bash script. I used this software to generate the CW
individual audio segments.  Finally, for (3), I employed another command line
sox program (SOund eXchange: universal sound sample translator;
[http://sox.sourceforge.net]).

Let me sum up: launching this bash script from the command prompt (e.g. by typing 
source generate_exercise.sh) of a
Terminal.app window in macOs, will create a single "exercise" mp3 file. This
audio file will be composed of N random "cw trials" (pairs of letters, in this example; 
but replace - where suggested in the code below - randomCharPairs by randomChar if you want to
generate single, isolated letters), each followed by a voice cue.

You can change the individual CW characters speed (WPM) and their "spacing"
(FPM) by modifying the values of the bash variables declared at the start of the 
script. Note that acting on the value of FPM also changes the time interval before
hearing the voice cue - giving one the time to comfortably pronounce (mentally
or aloud) which letter(s) just played.
In the future, having perhaps one or more ad-hoc "blank" mp3 files (each one with a desired
duration), could make it easier to control the pause betwene CW and the voice cues. 
It should also be possible to add prosigns and punctuations (eBook2CW supports them), 
although right now I am uncertain on how make voice cues compatible with them, without
making a longer and less concise bash script.

Enjoy!
