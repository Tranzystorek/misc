#!/bin/bash
# A script for generating dice throws using RPG-like syntax

function usage {
    echo -e\
         "Usage:\n"\
         `basename $0` " [-h | --help] [<T>d<S>]\n"\
         "where\n"\
         "T - number of throws\n"\
         "S - number of die sides";
}

if [ $# -gt 1 ]
then
    usage;
    exit 1;
fi

# default is one throw of a standard die
THROWS=1
SIDES=6

if [ $# -eq 1 ]
then
    if [ $1 = "-h" ] || [ $1 = "--help" ]
    then
        usage;
        exit 0;
    fi

    CHECK=`echo $1 | grep -Ecx '[1-9]([[:digit:]])*d[1-9]([[:digit:]])*'`

    if [ $CHECK -ne 1 ]
    then
        usage;
        exit 1;
    fi

    PARSED=`echo $1 | grep -Eo '[[:digit:]]+'`

    read THROWS SIDES < <(echo $PARSED)
fi

for i in `seq $THROWS`;
do
    echo $(( $RANDOM % $SIDES + 1 ));
done

