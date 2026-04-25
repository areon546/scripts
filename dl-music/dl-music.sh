#!/bin/bash

function download {

  # TODO: add check for url being set

  output="-o $HOME/Music/albums/$author/$album/$songname.%(ext)s"
  echo $output

  # TODO: add check for output being NEQ $HOME

  yt-dlp $output $url -x -f bestaudio

  filename=$(yt-dlp --print filename $output $url -x -f bestaudio)
  filename=$(echo $filename | sed 's/.webm/.opus/')
  # note: ytdlp downloads it as webm, but most of the time with -f bestaudio, it gets converted to opus
  # fix if this becomes an issue

  # Set tags
  kid3-cli $filename -c "set title '${songname}' set album '${album}' set artist '${author}' set tracknumber ${tracknum}"

  echo "new file: " $filename
  kid3-cli $filename -c "get"
}

function debug {
  if [ $doDebug -eq 1 ]; then
    echo "doDebug $doDebug"
    echo $mp4 $url $author $songname
  fi
}

function help {
  echo "Usage: "
  echo "	-h : display this"
  echo "	-u : url"
  echo "	-a : author / band"
  echo "	-l : album name"
  echo "	-t : song title"
  echo "	-n : tracknumber"
}

doDebug=0
url=""
author="a"
album="aa"
songname="aaa"
tracknum=1

while getopts "hma:l:t:u:n:" flag; do
  case "${flag}" in
  a) author=$OPTARG ;;
  l) album=$OPTARG ;;
  t) songname=$OPTARG ;;
  u) url=$OPTARG ;;
  n) tracknum=$OPTARG ;;
  h)
    help
    exit 0
    ;;
  esac
done

debug

if test -z "$url"; then
  help
  exit 0
fi

download
