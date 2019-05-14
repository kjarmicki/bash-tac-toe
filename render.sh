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
  echo ""
}

renderBoard() {
  for ((y=0; y<$boardHeight; y++)); do
    for ((x=0; x<$boardHeight; x++)); do
      value=$(boardGetFieldValue $x $y)
      renderedValue=$(renderFieldValue $value)
      format=""
      if [ $x -eq "${cursorPosition[0]}" ] && [ $y -eq "${cursorPosition[1]}" ]; then
        format="\e[7m"
      fi
      echo -ne "${format}${renderedValue}\e[0m"
      if [ $x -eq $((boardWidth - 1)) ]; then
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
