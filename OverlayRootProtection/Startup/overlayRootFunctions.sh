#!/bin/sh

isOverlayMountedOnRoot ()
{
	. /etc/environment

	if [ -z ${OVERLAY_ROOT_AT_BOOT+x} ]; then
	   #variable unset
	   return 1 #false
	fi

	if [ $OVERLAY_ROOT_AT_BOOT == false ]; then 
	    return 1 #false
	fi

	#overlay has been mounted on root
	return 0 #true
}

replaceOrAppendToFile ()
{
	FILE=$1
	LINE_TO_REPLACE=$2
	NEW_LINE=$3
	OPTION=

	if [ -z ${4+x} ]; then
	   #variable unset
	   OPTION=-q
	else
	   OPTION=$4
	fi

	if grep  $OPTION "$LINE_TO_REPLACE" $FILE; then 
	    sed -i '/'$LINE_TO_REPLACE'/c\'$NEW_LINE $FILE
	else
	    echo $NEW_LINE >> $FILE
	fi
}

lineExists ()
{
	FILE=$1
	LINE=$2
	OPTION=

	if [ -z ${3+x} ]; then
	   #variable unset
	   OPTION=-Fxq
	else
	   OPTION=$3
	fi

	if grep $OPTION "$LINE" $FILE; then 
	    return 0 #true
	fi

	return 1 #false
}

editLine ()
{
	FILE=$1
	OLD_LINE=$2
	NEW_LINE=$3
	sed -i 's/${OLD_LINE}/${NEW_LINE}/g' $FILE
}

isSecureEnvironment ()
{
	if ! isOverlayMountedOnRoot ; then 
	   return 1 #false
	fi

	return 0 #true
}

dirMounted ()
{
	if mount | grep $1 > /dev/null; then
	#mounted
	    return 0 #true
	else
	#not mounted
	    return 1 #false
	fi
}
