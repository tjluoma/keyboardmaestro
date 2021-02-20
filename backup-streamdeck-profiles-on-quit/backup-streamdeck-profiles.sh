#!/usr/bin/env zsh -f
# Purpose: 	Backup the 'ProfilesV2' folder within the 'Application Support' folder
#			for Stream Deck whenever the app quits.
#
#			This script is intended to be used with Keyboard Maestro as an
#			'Execute Shell Script' with 'display results in a window' enabled.
#			There will no no 'results' unless an error occurs.
#
#			This script exists because there is no way, that I know of, to automatically
#			back up your profiles. Automatic backups are the best backups because you
# 			do not have to think about them.
#
#			While this script is not a perfect substitute for backing up your profiles
#			manually, it does seek to provide a 'safety net' if something bad happens
#			to your Stream Deck setup / profiles between manual backups.
#
#			Script is provided free of charge but with no warranty expressed or implied.
#
#			If you do not use Keyboard Maestro (you should!) you can also call this script
#			manually, or via `launchd` (i.e. backup every night at midnight)
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2021-02-20


	# This is the directory where you want the backups to be saved _to_
	# You can change this  to any folder you want.
	# If it does not exist, the script will attempt to create it.
	# If it cannot be created, the script will use "$HOME/Desktop" instead
	# under the theory that a) if that folder doesn't exist, you have real problems
	# and b) if the files end up there, you will most likely notice them
	# and realize something has gone awry.
SAVE_DIR="$HOME/Dropbox"



	##############################################################
	## 	You should not have to change anything after this line	##
	##############################################################

	# this is where the Stream Deck config files are stored
	# this most likely will not change
CONFIG_DIR="$HOME/Library/Application Support/com.elgato.StreamDeck/ProfilesV2"

	## This 'if' block allows this script to be used outside of Keyboard Maestro
	## if so desired.
if [[ "$KMVAR_LOCAL_MacroName" == "" ]]
then

	NAME="$0:t:r"

else

	NAME="$KMVAR_LOCAL_MacroName"

fi

	# if there is a ~/.path file, use it
if [ -e "$HOME/.path" ]
then
	source "$HOME/.path"
fi

if [[ ! -d "$CONFIG_DIR" ]]
then
	echo "$NAME: '$CONFIG_DIR' does not exist."
	exit 1
fi

	# create SAVE_DIR if it does not exist
[[ ! -d "$SAVE_DIR" ]] && mkdir -p "$SAVE_DIR"

	# if SAVE_DIR _still_ does not exist for some reason
	# use ~/Desktop instead
[[ ! -d "$SAVE_DIR" ]] && SAVE_DIR="$HOME/Desktop"

	# yes I know about 'chroot' in `tar` but I like using `cd` better
	# in zsh '$CONFIG_DIR:h' is the same as `dirname "$CONFIG_DIR"`
cd "$CONFIG_DIR:h"

	# needed for 'strftime'
zmodload zsh/datetime

TIME=$(strftime "%Y-%m-%d--%H.%M.%S" "$EPOCHSECONDS")

	## will create files named like this:
	# StreamDeckProfiles-2020-09-27--23.17.15.tar.bz2
FILENAME="StreamDeckProfiles-${TIME}.tar.bz2"

	# create a .tar.bz2 file in SAVE_DIR with the filename above
	# using CONFIG_DIR as the source
tar --create --bzip2 --file "${SAVE_DIR}/${FILENAME}" "$CONFIG_DIR:t"

	# check to see if 'tar' reported success
EXIT="$?"

if [[ "$EXIT" == "0" ]]
then
		# if successful, add an entry in the default folder for macOS logs
		# this is done instead of just 'echo' so you can use
		# Keyboard Maestro's "Show Results in Window"
		# and only see error messages if they happen
	echo "$NAME: successful backup at $TIME" >>| "$HOME/Library/Logs/$NAME.log"

	exit 0

else

	echo "$NAME: 'tar' failed (exit code = $EXIT)"

	exit 1

fi

	# if we got here, something went wrong
exit 2

#EOF
