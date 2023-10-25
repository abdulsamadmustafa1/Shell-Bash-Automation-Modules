#!/bin/bash

f="/home/abdul-test/Shell-Bash-Automation-Modules/some.data" # you can change name or location according to your requirement

if [ ! -f $f ] #-f is representing file check and $f is the filename assigned in the above variable assignment.
then
  echo $f does not exist!
  exit
fi

touch ${f}
MAXSIZE=$((50))

size=`du -b ${f} | tr -s '\t' ' ' | cut -d' ' -f1` #cut -d is de limiter and -f1 giving first value of the output from du -b ,  if you write -f2 it will give you second value 
echo "The size of the file located at  " $f "is " $size"KB I have given Max size is 50KB"
if [ ${size} -gt ${MAXSIZE} ]
then
    echo Rotating! file, you will fine old file with same name alogn with date. It was greater than the allowed size.
    timestamp=`date +%s`
    mv ${f} ${f}.$timestamp #this program move the file in same location with timestamp and create new with same name, if we have defined some files can be maximum  $$ then rotate it.
    touch ${f}
fi


#It is really powerful example to track file sizes. Sys Admins can track file size and  move them to some other locations for example backup file increases max size then move from SSD disk to HDD disk.
#It can create same  name of the file so automation can also be not disturb.
