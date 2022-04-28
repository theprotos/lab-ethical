#!/usr/bin/bash

TARGET_SITE="https://cafefac.gitlab.io/cv"

cd ~
mkdir sites
cd sites

echo -e "  --> httrack: clone ${TARGET_SITE}"
mkdir httrack
cd httrack
httrack --ext-depth=1 ${TARGET_SITE}
cd ..

echo -e "  --> wget: clone ${TARGET_SITE}"
mkdir wget
cd wget
wget --page-requisites  --adjust-extension --mirror --convert-links --html-extension --wait=2 -o ${TARGET_SITE}.log $TARGET_SITE


cd ~
host ${TARGET_SITE}
nslookup ${TARGET_SITE}
dig -t axfr ${TARGET_SITE}