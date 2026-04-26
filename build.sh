#!/usr/bin/env bash

npm run build

mkdir _site

cp index.html _site/
cp favicon.ico _site/
cp -r dist _site/
