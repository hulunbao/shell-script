#!/bin/bash
# 清除日志脚本


LOG_DIR=/var/log
ROOT_ID=0  # $ROOT_UID为0的用户 ，即root用户

# 判断当前用户是否为root用户，不是则给出相应的提示

if [ "$UID" -ne "$ROOT_ID" ]
  then
    echo "Must be root to run this script."
    exit 1
fi

cd $LOG_DIR || {
    echo "Cannot change to necessary directory."
    exit 1
}

cat /dev/null>messages && {
    echo "Logs cleaned up."
    exit 0
}
echo "Logs cleaned up fail."
exit 1
