#!/bin/sh

. /etc/environment
. $OVERLAY_ROOT_SCRIPT_FUNCTIONS


TEXT=
PROTEC=

if ! isSecureEnvironment ; then
   PROTEC=false
   TEXT="Warning
System not secured"
else
   PROTEC=true
   TEXT="Protected
System secured"
fi

color_prompt=no
if test -t 1; then

    # see if it supports colors...
    ncolors=$(tput colors)

    if test -n "$ncolors" && test $ncolors -ge 8; then
	color_prompt=yes
        bold="$(tput bold)"
        underline="$(tput smul)"
        standout="$(tput smso)"
        normal="$(tput sgr0)"
	blink="$(tput blink)"
        red="$(tput setaf 1)"
        green="$(tput setaf 2)"
    fi
fi


if [ "$color_prompt" = yes ]; then #if the terminal support color
    if [ $PROTEC = true ]; then
	#display text with green color
	echo "${green}$TEXT"
    else
	#display text with red color and bold font
	echo "${red}${standout}${boldstandout}$TEXT"
    fi
else
    echo $TEXT
fi


#no exit because it will exit the login shell (so cannot connect an user)
