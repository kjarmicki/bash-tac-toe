#!/bin/bash

. ./board.sh
. ./cursor.sh
. ./players.sh
. ./input.sh
. ./render.sh

gameTryToPlaceLetter() {
  isFieldAtCurrentPositionEmpty=$(boardIsFieldEmpty "${cursorPosition[0]}" "${cursorPosition[1]}")
  if [ "$isFieldAtCurrentPositionEmpty" -eq 1 ]; then
    boardSetFieldValue "${cursorPosition[0]}" "${cursorPosition[1]}" "$playerCurrentField"
    boardFindAndRemoveConsecutiveFields
    playerSwitch
  fi
}

# debug
# gameTryToPlaceLetter
# cursorMoveDown
# gameTryToPlaceLetter
# cursorMoveUp
# cursorMoveRight
# gameTryToPlaceLetter
# cursorMoveDown
# gameTryToPlaceLetter
# cursorMoveUp
# cursorMoveRight
# gameTryToPlaceLetter
# cursorMoveDown
# gameTryToPlaceLetter
# cursorMoveUp
# cursorMoveRight
# gameTryToPlaceLetter

while [ : ]; do
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
