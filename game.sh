#!/bin/bash

. ./board.sh
. ./cursor.sh
. ./players.sh
. ./render.sh

for i in 1 2 3; do
  clear
  cursorMoveRight
  render
done
