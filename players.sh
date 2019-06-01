playerCurrentField=$boardFieldX
playerXScore=0
playerOScore=0

playerSwitch() {
  if [ $playerCurrentField -eq $boardFieldX ]; then
    playerCurrentField=$boardFieldO
  else
    playerCurrentField=$boardFieldX
  fi
}

playerCurrentAddScore() {
  score=$1
  if [ $playerCurrentField -eq $boardFieldX ]; then
    playerXScore=$((playerXScore + score))
  else
    playerOScore=$((playerOScore + score))
  fi
}
