boardFieldEmpty=0
boardFieldX=1
boardFieldO=2

boardWidth=4
boardHeight=4

boardGetPosition() {
  x=$1
  y=$2
  echo "$((y * boardHeight + x))"
}

boardFields=()
for ((y=0; y<$boardHeight; y++)); do
  for ((x=0; x<$boardHeight; x++)); do
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
