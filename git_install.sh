#!/bin/bash

echo "Start configure git"
rm -rf ${HOME}/.gitconfig
ln -s $(pwd)/git/gitconfig ${HOME}/.gitconfig
ln -s $(pwd)/git/git_template ${HOME}/.git_template

git config --global --unset http.proxy
git config --global --unset https.proxy
git config --global http.postBuffer 1048576000
echo "End configure git"
