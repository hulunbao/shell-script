#!/bin/bash
#	Script: funStrCmp.sh
#	Function to compare two strings
#	Return 0 if $1=$2
#		   1 if $1<$2
#		   2 if $1>$2


strcmp()
{
	if [[ $1 = $2 ]]
	then
		res=0
	else
		(echo "$1";echo "$2") > temp
		smaller=$(sort temp | head -l)
		if [[ $smaller = "$1" ]]
		then
			res=1
		else
			res=2
		fi
	fi
	return $res
}

strcmp $1 $2
res=$?

if (( $res==0 ))
	then
	echo "$1 = $2"
	else
		if (( $res==1 ))
		then
		echo "$1 < $2"
		else
		echo "$1 > $2"
		fi
fi
