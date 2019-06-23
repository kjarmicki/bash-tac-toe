boardFieldEmpty=1
boardFieldX=2
boardFieldO=3

boardSize=3
boardConsecutiveScoredThreshold=3

boardGetPosition() {
  x=$1
  y=$2
  echo "$((y * boardSize + x))"
}

boardFields=()
for ((y=0; y<$boardSize; y++)); do
  for ((x=0; x<$boardSize; x++)); do
    position=$(boardGetPosition $x $y)
    boardFields[$position]=$boardFieldEmpty
  done
done

boardGetFieldValue() {
  x=$1
  y=$2
  position=$(boardGetPosition $x $y)
  echo "${boardFields[$position]}"
}

boardSetFieldValue() {
  x=$1
  y=$2
  value=$3
  position=$(boardGetPosition $x $y)
  boardFields[$position]=$value
}

boardIsFieldEmpty() {
  value=$(boardGetFieldValue $1 $2)
  if [ $value -eq $boardFieldEmpty ]; then
    echo 1
  else
    echo 0
  fi
}

boardFindAndRemoveConsecutiveFields() {
  boardConsecutiveFieldsRemoved=0
  consecutiveHorizontal=0
  consecutiveVertical=0

  for ((y=0; y<$boardSize; y++)); do
    for ((x=0; x<$boardSize; x++)); do
      position=$(boardGetPosition $x $y)
      previousHorizontalPosition=$((position - 1))
      previousVerticalPosition=$((position - boardSize))
      currentField="${boardFields[$position]}"

      boardCheckHorizontalFields
      if [ "$consecutiveHorizontal" -eq "$boardConsecutiveScoredThreshold" ]; then
        boardRemoveHorizontalFields
        return
      fi

      # boardCheckVerticalFields
      # if [ "$consecutiveVertical" -gt "$boardConsecutiveScoredThreshold" ]; then
      #   boardRemoveVerticalFields
      #   return
      # fi

    done
  done

}

boardCheckHorizontalFields() {
  if [ "$currentField" -eq "$boardFieldEmpty" ] ||
      [ "$currentField" -ne "${boardFields[$previousHorizontalPosition]}" ] ||
      [ $((x % boardSize)) -eq 0 ]; then
      if [ "$consecutiveHorizontal" -gt "$boardConsecutiveScoredThreshold" ]; then
        boardRemoveHorizontalFields
        return
      fi
      if [ "$currentField" -ne "$boardFieldEmpty" ]; then
        consecutiveHorizontal=1
      else
        consecutiveHorizontal=0
      fi
  else
    consecutiveHorizontal=$((consecutiveHorizontal + 1))
  fi
}

boardCheckVerticalFields() {
  if [ "$currentField" -eq "$boardFieldEmpty" ] ||
      [ "$currentField" -ne "${boardFields[$previousVerticalPosition]}" ] ||
      [ $y -eq 0 ]; then
      if [ "$consecutiveVertical" -gt "$boardConsecutiveScoredThreshold" ]; then
        boardRemoveVerticalFields
        return
      fi
      if [ "$currentField" -ne "$boardFieldEmpty" ]; then
        consecutiveVertical=1
      else
        consecutiveVertical=0
      fi
  else
    consecutiveVertical=$((consecutiveVertical + 1))
  fi
}

boardRemoveHorizontalFields() {
  boardConsecutiveFieldsRemoved=$consecutiveHorizontal
  position=$((position + 1))
  while [ "$consecutiveHorizontal" -gt 0 ]; do
    position=$((position - 1))
    boardFields[$position]=$boardFieldEmpty
    consecutiveHorizontal=$((consecutiveHorizontal - 1))
  done
}

boardRemoveVerticalFields() {
  boardConsecutiveFieldsRemoved=$consecutiveVertical
  while [ "$consecutiveVertical" -gt 0 ]; do
    position=$((position - boardSize))
    boardFields[$position]=$boardFieldEmpty
    consecutiveVertical=$((consecutiveVertical - 1))
  done
}