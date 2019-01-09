#!/bin/bash
#
# Generate Training CW AudioFiles (macos version)
# Bash script - Version 0.1
#
# Requires: ebook2cw (to generate CW audio) and sox (to convert
# into and stitch together mp3 files)
#
# May the Morse be with you!

OUTPUTFILENAME=exercise.mp3  # Name of the audio file to be generated

N=3   	# Number of (random) characters to generate
WPM=25  	# (Character) speed, word per minute
FPM=10  	# Effective speed
PAUSE=0 	# Pause, in seconds, among groups
VOICE=Moira # This voice sounds very natural to me

# Set of characters to be randomly generated
chars=abcdefghijklmnopqrstuvwxyz1234567890

# Let's clean up spurious mp3 files in the current folder
rm -f *.mp3 rnd.txt

# If you do not like to have an "intro", comment the next 4 lines.
INTRO="Exercise at ``$FPM`` words per minute. Are you ready?,3,2,1,go!"
say --voice=$VOICE --rate=1 $INTRO -o 0a.aiff
sox 0a.aiff 0a.mp3 rate -s -a 44100 dither -s
rm 0a.aiff


# This bash function generates a random character
# and save the same character on disk, in a file.
randomChar() {
 mychar=${chars:RANDOM%${#chars}:1}
 echo $mychar
 echo $mychar > rnd.txt
}


# This bash function generates a pair of random chars
# and save them on disk, in a file. Note the use of the
# commas (only for the echo command), ensuring correct
# voice pronounciation as separate letters.
randomCharPairs() {
 mychar1=${chars:RANDOM%${#chars}:1}
 mychar2=${chars:RANDOM%${#chars}:1}
 echo $mychar1,$mychar2,
 echo $mychar1$mychar2 > rnd.txt
}


# Please note that below, a call to randomCharPairs() and not to
# randomChar() is made. In fact, I like to have training audio files
# with "pair" (not single, isolated random letters) to copy.
# Simply change the call from one to the other function, below, if
# you instead want single characters to be generated.

#----------------------------------------------------------------------
# The main loop - this might take several minutes (depending on N)
for i in `seq 1 $N`; do
	# Generate the voice synthesis cue
	randomCharPairs | say --voice=$VOICE --rate=1 -o $i.aiff
	sox $i.aiff ``$i``b.mp3 rate -s -a 44100 dither -s
	rm $i.aiff

	# Generate the cw waveform
	./ebook2cw -s 44100 -w $WPM -e $FPM -f 650 -W $PAUSE -T 0 -q 9 -o cw rnd.txt
	mv cw0000.mp3 ``$i``a.mp3
done
#----------------------------------------------------------------------

# Final concatenation of all audio files (depends on our convention for
# the filenames: can be sorted alphabetically and then stitched)
rm -f $OUTPUTFILE
fileList=$(ls *.mp3 | sort -h)
sox $fileList $OUTPUTFILENAME

# Clean up all the individual mp3 files created
rm *a.mp3 *b.mp3 rnd.txt
