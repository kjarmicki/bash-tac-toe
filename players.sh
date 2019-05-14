playerCurrentField=$boardFieldX

playerSwitch() {
  if [ $playerCurrentField -eq $boardFieldX ]; then
    playerCurrentField=$boardFieldO
  else
    playerCurrentField=$boardFieldX
  fi
}
