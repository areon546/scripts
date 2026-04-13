#!/bin/bash

function download {

  # TODO: add check for url being set

  title="$author-$songname"

  output="-o \"$title.%(ext)s\""
  echo $output

  # TODO: add check for output being set

  yt-dlp $output https://www.youtube.com/watch?v=at1jUGRBRig $mp3
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
  echo "	-m : whether you want to convert it to mp3 or not"
  echo "	-a : author / band "
  echo "	-s : song title "
  echo "	-u : url "
}
# m o: a: s: u:

doDebug=0
mp3=0
url=""
author="a"
songname="aa"

while getopts "hma:s:u:" flag; do
  case "${flag}" in
  m) mp3="-t mp3" ;;
  a) author=$OPTARG ;;
  s) songname=$OPTARG ;;
  u) url=$OPTARG ;;
  h)
    help
    exit 0
    ;;
  esac
done

debug

download
