#!/bin/bash

#*******************************************************************************
# This file is a part of Gitolite-Repository-Creator project
# Maintained by : Varuna Lekamwasam <vrlekamwasam@gmail.com>
# Authored By : Varuna Lekamwasam <vrlekamwasam@gmail.com>
#
# Gitolite-Repository-Creator is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Gitolite-Repository-Creator is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# For the GNU General Public License see <http://www.gnu.org/licenses/lgpl.html>
#******************************************************************************/

##checking for argument count
if [ $# -ne 2 ];
then
	echo 'Invalid number of arguments provided'
	echo 'Usage ./gitolite-repo-setup.sh <KEYS_COLLECTION_DIR> <GITOLITE_ADMIN_REPOSITORY_CLONE>'
	echo 'exitting...(Ex01)'
	exit -1;
fi
CURRENT_DIRECTORY=`pwd`
COLLECTION_DIRECTORY=$1
ADMIN_DIRECTORY=$2
if [ ! -d $COLLECTION_DIRECTORY ];
then
	echo 'Error in source directory. Please recheck the folder';
	echo 'exitting... (Ex02)';
	exit -2;
fi

if [ ! -d $ADMIN_DIRECTORY ];
then
	echo 'Invalid ADMIN_DIRECTORY...'
	echo 'exitting... (Ex03)'
	exit -3;
fi

cd $ADMIN_DIRECTORY
if [ ! `find -name *git -type d` ];
then
	echo 'Invalid GIT repository for ADMIN_DIRECTORY...'
	echo 'exitting... (Ex04)'
	exit -4;
fi
cd ..
#cd $COLLECTION_DIRECTORY

echo 'Starting automated configurations...'
for i in `find $COLLECTION_DIRECTORY -mindepth 1 -type d`
do 
	echo $i
	REPO_NAME=`echo $i | cut -d '/' -f2`
	echo 'Adding '$REPO_NAME' to configurations...'	
	PRJ_MEMBERS=''
	IS_CORRECT_ENTRY=0
	for PRJ_MEMBER in `find $COLLECTION_DIRECTORY/$REPO_NAME -name *.pub | cut -d '/' -f3 | cut -d '.' -f1`
	do
		PRJ_MEMBERS+=${PRJ_MEMBER}" "
		IS_CORRECT_ENTRY=1	
	done
	if [ $IS_CORRECT_ENTRY -eq 1 ];
	then
		echo "
repo    $REPO_NAME
	RW+	=   $PRJ_MEMBERS 
	$( cat ${ADMIN_DIRECTORY}/conf/gitolite.conf )" >  ${ADMIN_DIRECTORY}/conf/gitolite.conf;
		echo 'copying keys for repository '$REPO_NAME
		`cp $COLLECTION_DIRECTORY/$REPO_NAME/* $ADMIN_DIRECTORY/keydir/`
		cd $ADMIN_DIRECTORY
		`git add .`
		`git commit -m "configuring repository ${REPO_NAME} and adding user keys for ${PRJ_MEMBERS}"`
		cd $CURRENT_DIRECTORY
	fi
	echo $CURRENT_DIRECTORY
	echo `pwd`
done
echo 'Completed Configuring the repositories...'
echo 'Pushing to gitolite-administrations...'
cd $ADMIN_DIRECTORY
`git push`
echo 'Push completed...'
echo 'Exitting...'
