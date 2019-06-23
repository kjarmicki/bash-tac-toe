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
    if [ "$boardConsecutiveFieldsRemoved" -gt 0 ]; then
      playerCurrentAddScore $boardConsecutiveFieldsRemoved
    fi
    playerSwitch
  fi
}

# # horizontal
# cursorMoveDown
# cursorMoveDown
# gameTryToPlaceLetter
# cursorMoveUp
# gameTryToPlaceLetter
# cursorMoveRight
# cursorMoveDown
# gameTryToPlaceLetter
# cursorMoveUp
# gameTryToPlaceLetter
# cursorMoveRight
# cursorMoveDown
# gameTryToPlaceLetter
# cursorMoveUp
# gameTryToPlaceLetter

# vertical
gameTryToPlaceLetter
cursorMoveRight
gameTryToPlaceLetter
cursorMoveLeft
cursorMoveDown
gameTryToPlaceLetter
cursorMoveRight
gameTryToPlaceLetter
cursorMoveLeft
cursorMoveDown
gameTryToPlaceLetter


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
