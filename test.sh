#!/bin/bash 

if ! [[ $(java -version 2>&1 == *openjdk*) ]]; then
  echo "not installed"
else
  echo "installed"
fi

