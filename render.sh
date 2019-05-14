renderStatus() {
  echo "Now placing: ${playerCurrentField}"
  echo ""
}

renderBoard() {
  for ((y=0; y<$boardHeight; y++)); do
    for ((x=0; x<$boardHeight; x++)); do
      value=$(boardGetFieldValue $x $y)
      format=""
      if [ $x -eq "${cursorPosition[0]}" ] && [ $y -eq "${cursorPosition[1]}" ]; then
        format="\e[7m"
      fi
      echo -ne "${format}${value}\e[0m"
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
