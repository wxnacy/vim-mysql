#!/usr/bin/env bash

MSG=$1

git add . && git commit -m "${MSG}" && git push