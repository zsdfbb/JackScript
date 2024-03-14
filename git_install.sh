#!/bin/bash

echo "Start configure git"
rm -rf ${HOME}/.gitconfig
ln -s $(pwd)/git/gitconfig ${HOME}/.gitconfig
ln -s $(pwd)/git/git_template ${HOME}/.git_template
echo "End configure git"