#!/bin/bash
yellow=`tput setaf 3`
green=`tput setaf 2`
reset=`tput sgr0`

BugBranch=$1

if [[ ! $BugBranch ]]
	then 
		echo -e "Need bug fix branch!"
	exit 0
fi

FrameworkBranch=$(git rev-parse --abbrev-ref HEAD)

git checkout $BugBranch

git pull origin $BugBranch

git merge $FrameworkBranch --commit -m "Merged $FrameworkBranch into bug fix branch $BugBranch"

git checkout $FrameworkBranch

git merge --squash --no-commit $BugBranch
