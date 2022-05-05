#!/bin/bash

FILE=".makefile_updater.config"




if test -f "$FILE"
then
	echo "Config found"
	source ".makefile_updater.config"
else
	touch ".makefile_updater.config"
	while :
	do
		read -p 'Are we in the Makefile directory ? [y=yes/n=no] : ' ANSWER
		if [[ "$ANSWER" == "y" || "$ANSWER" == "n" ]]
		then
			if [ "$ANSWER" == "n" ]
			then
				echo 'Please put this script in your Makefile  directory :)'
				exit 0
			fi
			break
		fi
		echo 'Wrong INPUT. please write y or n'
	done

	while :
	do
		read -p 'Do you have a source directory with .c files ? [y=yes/n=no] : ' ANSWER
		if [[ "$ANSWER" == "y" || "$ANSWER" == "n" ]]
		then
			if [ "$ANSWER" == "y" ]
			then
				read -p 'Please write the name of the directory : ' SOURCES
				SOURCES="../${SOURCES}/"
			else
				SOURCES="../"
			fi
			break
		fi
		echo 'Wrong INPUT. please write y or n'
	done
	read -p 'Last question. what is the name of the SOURCES in your makefile ? : ' SOURCES_NAME
	echo "SOURCES=${SOURCES}" >> ".makefile_updater.config"
	echo "SOURCES_NAME=${SOURCES_NAME}" >> ".makefile_updater.config"
fi


NEW_SOURCES=$(ls -m $SOURCES*.c | tr -d ',')

NEWLINE="${SOURCES_NAME} = ${NEW_SOURCES}"

while IFS= read -r line
do
   ## take some action on $line
  if [[ $line == *"$SOURCES_NAME"* ]]
  then
  	sed -i "" "s|$line|$NEWLINE|" "../Makefile"
  	break
  fi
done < "../Makefile"

echo "Sources updated."
