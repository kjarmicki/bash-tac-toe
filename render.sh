renderStatus() {
  echo "Now placing: ${playerCurrentField}"
  echo ""
}

renderBoard() {
  for y in 0 1 2; do
    for x in 0 1 2; do
      value=$(boardGetFieldValue $x $y)
      format=""
      if [ $x -eq "${cursorPosition[0]}" ] && [ $y -eq "${cursorPosition[1]}" ]; then
        format="\e[7m"
      fi
      echo -ne "${format}${value}\e[0m"
      if [ $x -eq 2 ]; then
        echo ""
      fi
    done
  done
}

render() {
  renderStatus
  renderBoard
}
