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

#check the network and config before operation
function check_env() 
{
    git fetch --all 
    if [ $? -ne '0' ]; then
        echo "cann't connect to git repository,please check your network"
        exit 
    fi

    if [ -f ~/.gitconfig ]; then
        searchresult=$(cat ~/.gitconfig | grep "name")
        if [ -z "${searchresult}" ]; then
            echo "username has not been set,please use"
            echo "git config --global user.name "XXX""
            exit
        fi
        searchresult=$(cat ~/.gitconfig | grep "email")
        if [ -z "${searchresult}" ]; then
            echo "useremail has not been set,please use"
            echo "git config --global user.email "XXX""
            exit
        fi
    fi
}


#check the argument 2 is contained by argument 1
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

#check the branch is exist or not?
function search_branch()
{
    searchresult=$(git branch -avv|grep $1)
    if [ -z "${searchresult}" ]; then
        echo "branch: $1 didn't exist,please check your input"
        exit
    fi
}

#check the working_directory clean or not?
function search_status()
{
    searchresult=$(git status|grep "working directory clean")
    if [ -z "${searchresult}" ]; then
        echo "your working branch is not clean,are you sure to continue?(y/n)"
        read userbool
        if [ ${userbool} != 'y' ]; then
            exit
        fi
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
    search_status
    git push -u origin $branchname 2>&1 >/dev/null

    if [ $? -eq 0 ]; then
        echo "push success,notify your partner to review"
    else 
        echo "something is wrong"
    fi
}

function modify_branch()
{
    git branch
    read -p "Which branch do you want to push for review?" branchname
    search_branch $branchname 
    search_status
    git checkout $branchname 2>&1 >/dev/null
    echo "Now you are in branch $branchname,enjoy you code!"
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
        modify_branch
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
