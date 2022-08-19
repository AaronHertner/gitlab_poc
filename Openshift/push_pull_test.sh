#!/bin/sh
BORDER1='===================================================='
BORDER2='---------------------------------------------------'
START=`date +%s`
echo testing start at $BORDER1 $START s. 

#set user permissions
git config --global user.name "root"
git config --global user.password "password"

#pull repo
git_pull(){
    T=`date +%s`
    git clone https://root:T4dtFFFSQPxHK88QWhMy@gitlab.apps.xnkpeyx0.canadacentral.aroapp.io/gitlab-instance-15b29218/test1.git
    git remote add origin https://root:password@gitlab.apps.xnkpeyx0.canadacentral.aroapp.io/gitlab-instance-15b29218/test1.git

    cd test1
    echo repository contents $BORDER2 |
    git switch -c main
    echo repository pulled in $BORDER2 $(expr `date +%s` - $T) s
}
git_pull

#make rando files (1mb, 100mb, 1gb)
echo starting push test $BORDER1 |
truncate -s 1M one.txt
truncate -s 100M onehundred.txt
truncate -s 1000M onethousand.txt

#push
for file in one.txt onehundred.txt onethousand.txt
do
T=`date +%s`
git add $file
git commit -m 'adding file'
git push 
echo pushed $file in $BORDER2 $(expr `date +%s` - $T) s.
done

#delete and pull again
cd ..
rm -R -f test1
git_pull

#remove rando files and repo
cd ..
rm -R -f test1
echo removed repository at $BORDER2 $(expr `date +%s` - $START) s.
echo finish testing at $BORDER1 $(expr `date +%s` - $START) s.