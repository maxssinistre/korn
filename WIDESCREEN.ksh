ffmpeg -ab 128 -sameq -vcodec mpeg2video -padbottom 80 -padtop 80 -i $1 $1.new.mpg
