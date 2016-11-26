#!/bin/bash

ssh_arg=" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
SETSID=/usr/bin/setsid
tmp_file=/tmp/ssh_password

function sshpass () {
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
                is_password=no
            else
                if expr "$i" : "--password" >/dev/null && [ $is_password == no ]
                then
                    is_password=yes
                else
                    arg[${#arg[*]}]=$i
                fi
            fi

        done
        $SETSID $CMD ${arg[*]}
    else
        $CMD $*
    fi
}

if expr "$*" : ".*password:" >/dev/null
then
    touch $tmp_file
    cat $tmp_file
    rm -f $tmp_file
    exit
fi

CMD=$1
if [ "$CMD" == "" ]
then
    cat <<EOF
usage:
    sshpass <ssh|scp> <options..> [--password PASSWORD]

    PASSWORD: ssh login password
EOF
else
    shift
    sshpass $*
fi

#case $1 in
    #scp|ssh)
        #CMD
        #sshpass $*
        #;;
    #*)
        #cat <<EOF
        #usage:
        #sshpass <ssh|scp> <options..>
        #EOF
        #exit
        #;;
#esac

