boardFieldEmpty=0
boardFieldX=1
boardFieldO=2

boardWidth=3
boardHeight=3

boardFields=(
  $boardFieldEmpty $boardFieldEmpty $boardFieldEmpty
  $boardFieldEmpty $boardFieldEmpty $boardFieldEmpty
  $boardFieldEmpty $boardFieldEmpty $boardFieldEmpty
)

boardGetFieldValue() {
  x=$1
  y=$2
  position="$((y * boardHeight + x))"
  echo "${boardFields[$position]}"
}

boardSetFieldValue() {
  x=$1
  y=$2
  value=$3
  position="$((y * boardHeight + x))"
  boardFields[$position]=$value
}

boardIsFieldEmpty() {
  value=boardGetFieldValue $1 $2
  if [ $value -eq $boardFieldEmpty ]; then
    return 0
  else
    return 1
  fi
}
