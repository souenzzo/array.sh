#!/usr/bin/env sh

##########################################
# An array implementation in posix shell #
# using just builtin commands            #
# Tested on:                             #
# bash        ## 4.3.042-4               #
# bash        ## 3.2.057-3               #
# busybox sh  ## 1.21.1-2                #
# mksh        ## 51-1                    #
# dash        ## 0.5.8-1                 #
# zsh         ## 5.2-1                   #
##########################################

array () (
	new () {
		for elem in "$@"; do 
			echo "$elem"
		done
	}

	show () {
		DELIM="$1"
		shift
		OUT=""
		echo "$@" | while true; do
			if read -r elem; then
				OUT="${OUT}${elem}${DELIM}"
				continue
			fi
			echo "$OUT"
			return
		done
	}

	size () {
		i=0
		echo "$@" | while true; do
			if ! read -r elem; then
				echo "$i"
				return
			fi
			i=$(( i + 1 ))
		done
	}

	index () {
		i="-1"
		INDEX=""
		echo "$@" | while true; do
			if read -r elem; then
				INDEX="$INDEX $(( i = i + 1 ))" 
				continue
			fi
			echo "$INDEX"
			return
		done
	}

	get () {
		INDEX="$1"
		shift
		i="-1"
		echo "$@" | while read -r elem; do
			if test "$(( i = i + 1))" -eq "$INDEX"; then
				echo "$elem"
				return
			fi
		done
		echo

	}
	def () {
		INDEX="$1"
		shift
		VALUE="$1"
		shift
		i="-1"
		echo "$@" | while read -r elem; do
			test "$(( i = i + 1))" -eq "$INDEX" && elem="$VALUE"
			echo "$elem"
		done
	}
	"$@"
)
