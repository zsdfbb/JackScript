#!/bin/bash

echo "Start configure git"
rm -rf ${HOME}/.gitconfig ${HOME}/.git_template
cp $(pwd)/git/gitconfig ${HOME}/.gitconfig
cp $(pwd)/git/git_template ${HOME}/.git_template
cp $(pwd)/git/git_ignore ${HOME}/.git_ignore

git config --global --unset http.proxy
git config --global --unset https.proxy
git config --global http.postBuffer 1048576000
echo "End configure git"
