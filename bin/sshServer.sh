#!/bin/bash

jobNm=$1
authUser=$2
files=$3
dDir=$4
dServer=$5
fDir=$6
bkDir=$7
ccDir=$8
cmdStart=$9
cmdStop=${10}

  f=$(echo $srv | cut -c 1)
  if [ "$f" == "c" ]; then
    START_TOMCAT="sudo service tomcat6 start"
    STOP_TOMCAT="sudo service tomcat6 stop"
  else
    START_TOMCAT=start_tomcat
    STOP_TOMCAT=stop_tomcat
  fi

function start_application
{
 if [ -n "$cmdStart" ]; then 
    echo "$cmdStart"
    $sshSrv $cmdStart
    [ "$?" != 0 ] && exit 1
    sleep 5
 fi
} 

function stop_application
{
 if [ -n "$cmdStop" ]; then 
   echo "$cmdStop"
   $sshSrv $cmdStop
   [ "$?" != 0 ] && exit 1
   sleep 5
 fi
}

function backup_files
{
  if [ -n "$files" ]; then
   for file in $(echo "$files" | sed 's/,/ /g')
   do
     echo "Backup $dDir/$file to $bkDir/$jobNm  ... " 
     sh bin/esc.sh $sshSrv [ ! -d $bkDir/$jobNm ] && sh bin/esc.sh $sshSrv mkdir $bkDir/$jobNm
     sh bin/esc.sh $sshSrv [ -d $bkDir ] && sh bin/esc.sh $sshSrv cp $dDir/$file $bkDir/$jobNm/$file || echo "Backup $file [ FAIL ]" 
   done
  fi

}

function clear_cache
{
 if [ -n "$ccDir" ]; then
   for cdir in $(echo "$ccDir" | sed 's/,/ /g')
   do
     echo "Remove cache $cdir ... "
     $sshSrv [ -d $cdir ] || [ -f $cdir ] && sh bin/esc.sh $sshSrv rm -rf $cdir/* || echo "Remove Cache : $cdir [ FAIL ]"
   done
 fi
}

function upload_files
{
 if [ -n "$files" ]; then
   for file in $(echo "$files" | sed 's/,/ /g')
   do
     if [ -f "$fDir/$file" ]; then
       echo "upoading $fDir/$file to ~"
       $sshSrv rm -rf ~/$file
       #echo "scp $fDir/$file $srv:~/$file"
       scp $fDir/$file $srv:~/$file
       [ "$?" != 0 ] && exit 1 && echo "Upload $file [ OK ]"
       sleep 3
     else
       echo "Upload $file, not found in $fDir [ FAIL ]"
       exit 1
     fi
   done
 fi
}

function ping_server
{
 ssh -o ConnectTimeout=10 $authUser@$srv echo "Connecting $authUser@$srv [ OK ]" 2>/dev/null
 [ "$?" != 0 ] && echo "Connecting $authUser@$srv [ FAIL ]" && exit 1 
}

function deployFiles
{
 if [ -n "$files" ]; then
   for file in $(echo "$files" | sed 's/,/ /g')
   do
     if [ -f "$fDir/$file" ]; then
       echo "deploy ~/$file to $dDir directory"
       sh bin/esc.sh $sshSrv rm $dDir/$file
       sh bin/esc.sh $sshSrv cp ~/$file $dDir/$file
       [ "$?" != 0 ] && echo "deploy $file [ FAIL ]" && exit 1
     fi
   done
 fi  
}

for srv in $(echo "$dServer" | sed 's/,/ /g')

do 
 sshSrv="ssh $authUser@$srv"
 [ "$cmdStart" = "start_tomcat" ] && cmdStart=$START_TOMCAT
 [ "$cmdStop" = "stop_tomcat" ] && cmdStop=$STOP_TOMCAT
 
 ping_server
 upload_files
 sleep 2
 backup_files
 stop_application
 clear_cache
 sleep 2
 deployFiles
 start_application
done
 
