#!/bin/bash
#This shell	script will create amount of linux login accounts for you.
# 1.check the "accountadd.txt" file exits? you must create that file manually.
# one account name one line in the "account.txt" file.
# 2.use openssl to create users password.
# 3.User must change his password in his first login.


export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# 0. userinput
usergroup=""					#if your account need secendary group,add here.
pwmech="openssl"				#"openssl" or "account" is needed.
homeperm="no"					#if "yes" then I will modify home dir permission to 711


# 1. check accountadd.txt file
action="${1}"					#"create" is useradd and "delete" is userdel
if [ ! -f accountadd.txt ]; then
	echo "There is no accountadd.txt file,stop here."
	exit 1
fi


[ usergroup != "" ] $$ groupadd -r ${usergroup}
rm -f outputpw.txt
username=$(cat accountadd.txt)

for username in ${username}
do
	case ${action} in
	"create")
		[ "${usergroup}" != "" ] && usegrp=" -G ${usergroup} " || usrgrp=""
		useradd ${usegrp} ${username}				# add new account
		[ "${pwmech}" == "openssl" ] && usepw=$(openssl rand -base64 6) || usepw=${username}
		echo $usepw | passwd --stdin ${username}	# create password
		chage -d 0 ${username}						# Force login to change password
		[ "${homeperm}" == "yes" ] && chmod 711 /home/${username}
	echo "username=${username},password=${usepw}" >> output.txt
		;;
	"delete")
		echo "deleting ${username}"
		userdel -r ${username}
		;;
	*)
		echo "Usage: $0 [create|delete]"
		;;
	esac
done
