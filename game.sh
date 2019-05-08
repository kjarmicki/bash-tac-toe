#!/bin/bash

. ./board.sh
. ./cursor.sh
. ./players.sh
. ./input.sh
. ./render.sh

while [ : ]; do
  clear
  render
  gameInputCode=$(inputRead)
  case $gameInputCode in
    "${inputCodeUp}")
      cursorMoveUp
      ;;
    "${inputCodeDown}")
      cursorMoveDown
      ;;
    "${inputCodeLeft}")
      cursorMoveLeft
      ;;
    "${inputCodeRight}")
      cursorMoveRight
      ;;
  esac
done
