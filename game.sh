#!/bin/bash

. ./board.sh
. ./cursor.sh
. ./players.sh
. ./input.sh
. ./render.sh

gameTryToPlaceLetter() {
  boardSetFieldValue "${cursorPosition[0]}" "${cursorPosition[1]}" "$playerCurrentField"
}

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
    "${inputCodeAction}")
      gameTryToPlaceLetter
      ;;
  esac
done
