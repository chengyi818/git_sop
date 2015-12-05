#Maintainer: Fat cheng
#Email： chengyi818@foxmail.com
#Description:
#This is a bash shell script designed for git beginner.
#The interactive script can reduce the difficulty when using git.
#The script provide serveral Standard Operation Procedure.
#If you are not familiar with git and our SOP,using this script is a good choice.
#If you are familiar with git,I suggest you can use git with command line by your own.
#Anyway,I hope you will like git and coding.


#!/bin/sh

function check_env() 
{
    git fetch --all 
    if [ $? -ne '0' ]; then
        echo "cann't connect to git repository,please check your network"
        exit 
    fi
}

function search_result()
{
    searchresult=$(echo $1|grep $2)
    if [ -z "${searchresult}" ]; then
        echo "$1 is not a recommend name,do you want continue(y/n)?"
        read userbool
        if [ ${userbool} != 'y' ]; then
            exit
        fi
    fi
}

function search_branch()
{
    searchresult=$(git branch -avv|grep $1)
    if [ -z "${searchresult}" ]; then
        echo "branch: $1 didn't exist,please check your input"
        exit
    fi
}

function develop_new_feature()
{
    read -p "Please give me a branch name,such as Featrure-XXX:" branchname

    search_result $branchname "Feature-"

    git branch $branchname origin/develop 2>&1 >/dev/null
    git checkout $branchname  2>&1 >/dev/null
    echo "Now you are in branch $branchname,enjoy your code!"
}

function fix_bug()
{
    read -p "Please give me a branch name,such as Bug-XXX:" branchname

    search_result $branchname "Bug-"

    git branch $branchname origin/develop 2>&1 >/dev/null
    git checkout $branchname  2>&1 >/dev/null
    echo "Now you are in branch $branchname,Fix the bug Now!"
}

function push_for_review()
{
    git branch
    read -p "Which branch do you want to push for review?" branchname
    search_branch $branchname 

    git checkout $branchname 2>&1 >/dev/null
    git push -u origin $branchname 2>&1 >/dev/null

    if [ $? -eq 0 ]; then
        echo "push success,notify your partner to review"
    else 
        echo "something is wrong"
    fi
}



echo "Welcome,what do you want?"
echo "1) develop a new feature"
echo "2) fix a bug in develop branch"
echo "3) push a branch for review"
echo "4) modify a branch after review failure"
echo "5) commit a branch after review success"
echo "6) review a branch"
echo "7) review a branch success"

read -p "Please input the index number:" userchoice

case $userchoice in
    "1")
        check_env
        develop_new_feature
        ;;
    "2")
        check_env
        fix_bug
        ;;
    "3")
        check_env
        push_for_review
        ;;
    "4")
        echo $userchoice
        ;;
    "5")
        echo $userchoice
        ;;
    "6")
        echo $userchoice
        ;;
    "7")
        echo $userchoice
        ;;
    *)
        echo "unsupport input,you can rerun the script"
        ;;
esac
