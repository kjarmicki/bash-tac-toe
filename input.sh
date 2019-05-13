inputUp="w"
inputDown="s"
inputLeft="a"
inputRight="d"
inputAction="l"

inputCodeUp="UP"
inputCodeDown="DOWN"
inputCodeLeft="LEFT"
inputCodeRight="RIGHT"
inputCodeAction="ACTION"
inputCodeUnknown="UNKNOWN"

inputRead() {
  read -n 1 -s -r input
  case $input in
    "${inputUp}")
      echo $inputCodeUp
      ;;
    "${inputDown}")
      echo $inputCodeDown
      ;;
    "${inputLeft}")
      echo $inputCodeLeft
      ;;
    "${inputRight}")
      echo $inputCodeRight
      ;;
    "${inputAction}")
      echo $inputCodeAction
      ;;
    *)
      echo $inputCodeUnknown
      ;;
  esac
}