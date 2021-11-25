#/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

WIDTH=3440
HEIGHT=1440
DIR=/Users/kwanguhu/Backgrounds
#IMG_BACKUP_DIR=/Users/kwanguhu/Backgrounds/IMAGE_BACKUP_DIR

#if [[ ! -e ${IMG_BACKUP_DIR} ]]; then
#    mkdir ${IMG_BACKUP_DIR}
#fi

cd ${DIR}
#/usr/bin/osascript -e 'tell application "System Events" to tell every desktop to set picture to "/Users/kwanguhu/Backgrounds/temp.jpg"'
URI=$(/usr/bin/curl --silent -I "https://picsum.photos/${WIDTH}/${HEIGHT}.jpg?random"|grep -e "^location:"|sed 's/^location: //g'|sed 's/\r$//')
IMG=$(echo $URI | sed 's/.*=//g' | sed 's/[^0-9]//g')
TIMESTAMP=`date '+%Y%m%d%H%M'`

# remove images older than 1 day
#YESTERDAY=`date -v-1d '+%Y%m%d'`
find . -type f -maxdepth 1 -mtime +1 -print0 | xargs -0 -I {} rm {}

FILENAME="${WIDTH}_${HEIGHT}_${TIMESTAMP}.jpg"
#echo ${FILENAME}

/usr/bin/curl ${URI} --silent -o ${FILENAME}
/usr/bin/osascript -e 'tell application "System Events" to tell every desktop to set picture to "'${DIR}/${FILENAME}'"'

