#!/bin/sh
BORDER1='===================================================='
BORDER2='---------------------------------------------------> '
START=`date +%s`
REPO='test2'
BRANCH_NAME=push-pull-test-`date +%s`

echo testing start at $BORDER1 $START s. 

# set user permissions
git config --global user.name "root"
git config --global user.password "password"

# pull repo
echo pull repository $BORDER1
git_pull(){
    T=`date +%s`
    git clone https://root:T4dtFFFSQPxHK88QWhMy@gitlab.apps.xnkpeyx0.canadacentral.aroapp.io/gitlab-instance-15b29218/$REPO.git
    if [ -d "`pwd`/${REPO}" ]
    then
        echo repository pulled in $BORDER2 $(expr `date +%s` - $T) s
        cd $REPO
    else
        echo 'repository could not be pulled'
        exit 0
    fi
}
git_pull

# create branch
echo creating branch $BORDER1
git checkout -b $BRANCH_NAME

# make rando files (1mb, 100mb, 1gb)
echo making files for commits $BORDER1
head -c 1MB /dev/urandom > one.txt
head -c 100MB /dev/urandom > onehundred.txt
head -c 500MB /dev/urandom > fivehundred.txt
echo done...

# push the files
echo pushing files to remote branch $BORDER1
for file in one.txt onehundred.txt fivehundred.txt
do
    T=`date +%s`
    git add $file
    git commit -m 'adding file'
    git push --set-upstream origin $BRANCH_NAME
    echo pushed $file in $BORDER2 $(expr `date +%s` - $T) s.
done

# merge the branches
echo merging branch with main $BORDER1
T=`date +%s`
git checkout main
git merge $BRANCH_NAME
echo merge completed in $BORDER2 $(expr `date +%s` - $T) s.

# clear repo for reuse
echo clearing all files from repository $BORDER1
rm -rf *.txt
git add .
git commit -m 'removing all files'
git push

# remove the repository itself
cd ..
rm -rf $REPO
echo finish testing at $BORDER1 $(expr `date +%s` - $START) s - total elapsed time.
