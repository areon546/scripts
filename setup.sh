#!/bin/bash

read -d '' help <<-EOF
Usage: $(basename $0) [script]

Script:
Name of the shell script (excluding suffix) you want to add to the path.
EOF

if [ $# != 1 ]; then
  echo "$help"
  exit 0
fi

script=$1

cp ${script}.sh ~/.local/bin/${script}
chmod u+x ~/.local/bin/${script}
