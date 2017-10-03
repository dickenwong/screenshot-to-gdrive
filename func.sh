#!/bin/bash
set -e


get_dir_id () {
    # optional function
    FOLDER_NAME=$1
    echo $(gdrive list --no-header -m 100 -q "name = '${FOLDER_NAME}'" | awk -F ' ' 'NR==1{print $1}')
}


upload () {
    URL=$1
    PARENT_DIR_ID=$2

    FILE_PATH=$(PATH=$PATH:$PWD/phantomjs-2.5.0-beta-macos/bin ./node_modules/casperjs/bin/casperjs --ignore-ssl-errors=true main.js $URL)
    DATE_STR="$(date "+%Y-%m-%d %T") $((RANDOM % 1000))"

    echo $FILE_PATH
    echo $DATE_STR

    gdrive upload \
        --parent $PARENT_DIR_ID \
        --name "Screenshot ${DATE_STR}.png"  \
        ${FILE_PATH}
}

