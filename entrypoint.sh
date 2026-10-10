test -n "$INTERACTIVE_CONFIG" && tail -f /dev/null || { 
  cd /RainbowMiner
  bash start.sh &
  child=$!
  trap 'echo adios > /RainbowMiner/stopp.txt; wait $child' TERM INT
  wait $child
}
