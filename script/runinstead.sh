#!/bin/bash

if [ $2 ]; then
  kill $2
  wait $!
fi
gamespath=$1
expression="instead -debug -gamespath $gamespath -game . &"
eval $expression
echo $!
