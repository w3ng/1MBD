#!/bin/bash
echo "esc.sh -> $*"
str=""
count=0
for s in $*
do
  if [ "$count" == "0" ]; then
   str="$s"
   count=1
  elif [ "$count" == "1" ]; then
   str="$str $s"
   count=2
  elif [ "$count" == "2" ]; then
   str="$str sudo -A $s"
   count=3
  else
   str="$str $s"
  fi
done

$* 2>/dev/null
if [ "0" != "$?" ]; then
 #$str 2>/dev/null
 $str
 echo "esc.sh -> $str : $?"
 exit $?
fi

exit 0




