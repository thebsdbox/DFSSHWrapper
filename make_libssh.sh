#!/bin/bash
########################################################
# Author: Daniel Finneran (dan@thebsdbox.co.uk)
# Date: 12/11/12 Version: v0.1
# Notes: This script is used to put together the headers
# the archive library ready for use with cocoa project
########################################################

ARCHIVE_DIR="libssh_archive"
PROJECT_DIR="libssh2_xcode"
WORKING_DIR=`pwd`
############## Code Begins here ########################

function create_project()
{
	mkdir -p $WORKING_DIR/$PROJECT_DIR
	mkdir -p $WORKING_DIR/$PROJECT_DIR/headers
	mkdir -p $WORKING_DIR/$PROJECT_DIR/lib
}

#Only one argument, which is the path to the libssh archive

echo "Processing $1"
if [ -f $1 ];
then 
	echo "Extracting Archive from $1"
else
	echo "$1 does not exist, Exiting."
	exit -1;
fi
mkdir -p $WORKING_DIR/$ARCHIVE_DIR 
tar -xvzf $1 -C ./$ARCHIVE_DIR
pwd
mv $WORKING_DIR/$ARCHIVE_DIR/libssh*/* $WORKING_DIR/$ARCHIVE_DIR/
pwd
# echo move into directory to build 
cd $WORKING_DIR/$ARCHIVE_DIR/
# Run configure script
./configure 
# Run make binary
make

create_project
echo "Copying Headers into project directory"
find $WORKING_DIR/$ARCHIVE_DIR/src -name "*.h" -exec cp {} $WORKING_DIR/$PROJECT_DIR/headers/ \; 
cp $WORKING_DIR/$ARCHIVE_DIR/include/* $WORKING_DIR/$PROJECT_DIR/headers/
echo "Copying Library archive into project directory"
cp $WORKING_DIR/$ARCHIVE_DIR/src/.libs/libssh2.a $WORKING_DIR/$PROJECT_DIR/lib
#echo move out once built
cd ..

rm -rf ./$ARCHIVE_DIR/
