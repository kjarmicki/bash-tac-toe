renderFieldValue() {
  value=$1
  case $value in
    "${boardFieldEmpty}")
      echo "☐"
      ;;
    "${boardFieldX}")
      echo "X"
      ;;
    "${boardFieldO}")
      echo "O"
      ;;
  esac
}

renderStatus() {
  echo "Now placing: $(renderFieldValue $playerCurrentField)"
  echo "C: ${debug}"
}

renderBoard() {
  for ((y=0; y<$boardSize; y++)); do
    for ((x=0; x<$boardSize; x++)); do
      value=$(boardGetFieldValue $x $y)
      renderedValue=$(renderFieldValue $value)
      format=""
      if [ $x -eq "${cursorPosition[0]}" ] && [ $y -eq "${cursorPosition[1]}" ]; then
        format="\e[7m"
      fi
      echo -ne "${format}${renderedValue}\e[0m"
      if [ $x -eq $((boardSize - 1)) ]; then
        echo ""
      fi
    done
  done
}

render() {
  clear
  renderStatus
  renderBoard
}
