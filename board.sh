boardFieldEmpty=1
boardFieldX=2
boardFieldO=3

boardSize=4
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
  consecutiveFields=0

  # horizontal check
  for ((y=0; y<$boardSize; y++)); do
    for ((x=0; x<$boardSize; x++)); do
      position=$(boardGetPosition $x $y)
      previousX=$((x - 1))
      previousPosition=$(boardGetPosition $previousX $y)
      currentField="${boardFields[$position]}"

      boardCheckFields $x
      if [ "$consecutiveFields" -eq "$boardConsecutiveScoredThreshold" ]; then
        boardRemoveFields x
        return
      fi

    done
  done

  # vertical check
  for ((x=0; x<$boardSize; x++)); do
    for ((y=0; y<$boardSize; y++)); do
      position=$(boardGetPosition $x $y)
      previousY=$((y - 1))
      previousPosition=$(boardGetPosition $x $previousY)
      currentField="${boardFields[$position]}"

      boardCheckFields $y
      if [ "$consecutiveFields" -eq "$boardConsecutiveScoredThreshold" ]; then
        boardRemoveFields y
        return
      fi

    done
  done

}

boardCheckFields() {
  boundary=$1
  if [ "$currentField" -eq "$boardFieldEmpty" ] ||
      [ "$currentField" -ne "${boardFields[$previousPosition]}" ] ||
      [ $((boundary % boardSize)) -eq 0 ]; then
      if [ "$consecutiveFields" -gt "$boardConsecutiveScoredThreshold" ]; then
        boardRemoveFields
        return
      fi
      if [ "$currentField" -ne "$boardFieldEmpty" ]; then
        consecutiveFields=1
      else
        consecutiveFields=0
      fi
  else
    consecutiveFields=$((consecutiveFields + 1))
  fi
}

boardRemoveFields() {
  dimension=$1
  boardConsecutiveFieldsRemoved=$consecutiveFields
  while [ "$consecutiveFields" -gt 0 ]; do
    boardFields[$position]=$boardFieldEmpty
    consecutiveFields=$((consecutiveFields - 1))
    if [ "$dimension" == "x" ]; then
      position=$((position - 1))
    fi
    if [ "$dimension" == "y" ]; then
      position=$((position - boardSize))
    fi
  done
}
