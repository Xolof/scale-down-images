#!/usr/bin/bash

<<'END'
#########################################
#      More verbose solution            #
#########################################
END

getDirSize () {
  echo $(du -d 1 $directory | grep -E "$directory$" | cut -f 1)
}

green='\033[1;32m'
blue='\033[1;34m'
teal='\033[1;36m'
clear='\033[0m'

# Set the script to exit if there's an error.
set -e

# read won't process any special escapes in the argument to -p, so we need to specify them literally. bash's ANSI-quoted strings are useful for this.
read -p $'This script will scale down \e[1;31mALL\e[0m images in a directory and its subdirectories. \nEnter path to directory: ' directory

# Check if the directory exists and print stderr in bold red.
ls $directory 1> /dev/null 2> >(while read line; do echo -e "\e[01;31m$line\e[0m" >&2; done)

printf "You have entered the directory:${blue} $directory\n${clear}"
read -p 'Do you want to continue? [Y/n] ' answer

# If the user pressed enter, y or yes with upper or lower caps, then proceed, else exit.
if [[ ! $answer =~ Y|y|[Yy][Ee][Ss]|^$ ]]; then
  printf "Aborting\n"
  exit 0
fi;

printf "Converting\n"

# Read paths for all images with a size over 50kB into an array.
mapfile -t files < <(find $directory -size +50k -regextype egrep -regex ".*webp$|.*.jpg|.*jpeg|.*.png")

# Get the size of directory before scaling.
dirSizeBefore=$(getDirSize $@)

# Loop through the files and convert them.
filesLength=${#files[@]}
for ((i = 0; i < $filesLength; ++i)); do
    filePath="${files[$i]}"
    printf "${teal}Converting image $(($i+1))/$filesLength:${clear} $filePath\n"
    convert "$filePath" -scale 75% "$filePath"
done

dirSizeAfter=$(getDirSize $@)
spaceSaved=$((($dirSizeBefore - $dirSizeAfter)/1000))
printf "\n${green}$(echo "${#files[@]}") files have been converted."
printf "\nYou saved $spaceSaved MB.${clear}\n"

exit 0

