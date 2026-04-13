#/bin/bash

function readInput {
  message=$1
  varname=$2

  echo "$1"
  read val

  # export temp value in a variable named based on input 2
  # eg:
  # readInput "ADSA" "polly"
  # would result in the input being stored within $polly
  export $2="$val"

}

function main {

  name=$cli
  debug

  echo "[1/2] Download Flatpak"
  # if flaturl still default, "", ask user to input one
  if [ -z $flaturl ]; then
    readInput "Input flatpak identifier" "flaturl"
  fi

  flatpak install $flaturl "$yes"

  echo "[2/2] Create Binary File in .local"

  if [ -z $name ]; then
    readInput "Input name of cli command" "name"
  fi

  if [ -z $name ]; then
    echo "No name was entered for command"
    exit 1
  fi

  # main code
  filename="$HOME/.local/bin/$name"
  touch $filename
  tee $filename <<EOF
#!/bin/bash
EOF

  echo "flatpak run $flaturl" >>$filename

  echo "Run the following command to make this flatpak executable. "
  echo "chmod u+x $filename"

  # cat $filename
}

function debug {
  if [ $doDebug -eq 1 ]; then
    echo "flaturl $flaturl"
    echo "cli     $cli"
    echo "exe     $exe"
    echo "yes     $yes"
    echo "doDebug $doDebug"
  fi
}

function help {
  echo "Usage: "
  echo "      -h : display this"
  echo "      -i : the flatpak identifier you want to download"
  echo "      -c : the command you want to use to run the flatpak"
  echo "      -d : turn debug on"
  #echo "      -x : makes the command executable"
  #echo "      -y : automatically accept anything involved in installation process"
}

flaturl=""
cli=''
exe=0
yes=""
doDebug=0

while getopts "c:i:-hdxy" opt; do
  case $opt in
  i) flaturl="$OPTARG" ;; # identifier
  c) cli="$OPTARG" ;;     # cli name
  d) doDebug=1 ;;
  x) exe=1 ;;
  y) yes="-y" ;;
  h)
    help
    exit 0
    ;;
  -)
    case "${OPTARG}" in
    help)
      help
      exit 0
      ;;
    *) echo "Unknown option --${OPTARG}" ;;
    esac
    ;;
  *) echo "Unknown option -${OPTARG}" ;;
  esac
done

main
