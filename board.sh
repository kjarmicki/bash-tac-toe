boardFieldEmpty=0
boardFieldX=1
boardFieldO=2

boardSize=4
boardConsecutiveScoredThreshold=2

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
  consecutiveHorizontal=1
  consecutiveVertical=1
  consecutiveDiagonalLeft=1
  consecutiveDiagonalRight=1
  lastPosition=$((boardSize * boardSize - 1))

  for ((y=0; y<$boardSize; y++)); do
    for ((x=0; x<$boardSize; x++)); do
      position=$(boardGetPosition $x $y)
      previousPosition=$((position - 1))
      currentField="${boardFields[$position]}"

      if [ "$currentField" -eq "$boardFieldEmpty" ] ||
         [ "$currentField" -ne "${boardFields[$previousPosition]}" ] ||
         [ $((x % boardSize)) -eq 0 ] ||
         [ "$position" -eq "$lastPosition" ]; then
           if [ "$consecutiveHorizontal" -gt "$boardConsecutiveScoredThreshold" ]; then
             echo "$consecutiveHorizontal"
             while [ "$consecutiveHorizontal" -gt 0 ]; do
               position=$((position - 1))
               boardFields[$position]=$boardFieldEmpty
               consecutiveHorizontal=$((consecutiveHorizontal - 1))
             done
             return
          fi
          consecutiveHorizontal=1
      else
        consecutiveHorizontal=$((consecutiveHorizontal + 1))
      fi

    done
  done
}
