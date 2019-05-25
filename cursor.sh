cursorPosition=(0 0)

cursorMoveLeft() {
  cursorPosition[0]=$((${cursorPosition[0]}-1))
  if [ "${cursorPosition[0]}" -eq -1 ]; then
    cursorPosition[0]=$(($boardSize-1))
  fi
}

cursorMoveRight() {
  cursorPosition[0]=$((${cursorPosition[0]}+1))
  if [ "${cursorPosition[0]}" -eq $boardSize ]; then
    cursorPosition[0]=0
  fi
}

cursorMoveUp() {
  cursorPosition[1]=$((${cursorPosition[1]}-1))
  if [ "${cursorPosition[1]}" -eq -1 ]; then
    cursorPosition[1]=$(($boardSize-1))
  fi
}

cursorMoveDown() {
  cursorPosition[1]=$((${cursorPosition[1]}+1))
  if [ "${cursorPosition[1]}" -eq $boardSize ]; then
    cursorPosition[1]=0
  fi
}
