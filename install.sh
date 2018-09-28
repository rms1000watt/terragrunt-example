#!/usr/bin/env bash

if [[ $(uname) != "Darwin" ]]; then
  echo "ERROR: Install only works on OS X"
  exit 1
fi

if ! command -v brew &> /dev/null; then
  echo "ERROR: Homebrew not installed"
  echo "Download Homebrew from: https://brew.sh/"
  exit 1
fi

if ! command -v pip &> /dev/null; then
  echo "ERROR: Pip not installed"
  echo "Install Python's pip then continue"
  exit 1
fi

brew install terraform terragrunt jq sshuttle
brew cask install docker
pip install awscli --user
