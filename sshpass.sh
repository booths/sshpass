#!/bin/bash

SSH=/usr/bin/ssh
tmp_file=/tmp/ssh_password

if expr "$*" : ".*password:" >/dev/null
then
    touch $tmp_file
    cat $tmp_file
    rm -f $tmp_file
    exit
fi

export DISPLAY=:0
export SSH_ASKPASS=$(cd `dirname $0`;pwd)/`basename $0`

if expr "$*" : ".*--password.*" >/dev/null
then
    arg=()
    is_password=no
    for i in $* 
    do
        if [ $is_password == yes ]
        then
            echo "$i" >$tmp_file
        else
            if expr "$i" : "--password" >/dev/null && [ $is_password == no ]
            then
                is_password=yes
            else
                arg[${#arg[*]}]=$i
            fi
        fi

    done
fi

setsid $SSH ${arg[*]}
