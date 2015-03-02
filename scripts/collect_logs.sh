#!/bin/sh

log(){
    tput setaf 2; echo "[`date`]: $1"; tput sgr0
}


logerr(){
    tput setaf 1; echo "[`date`]: $1"; tput sgr0
}

hostname="localhost"
hostport="5544"
initdirname="${1:-$(pwd)}"



echo "Collecting files in $initdirname"
files=`find $initdirname -name *.zip`

log "found these files:\n$files"

echo "Unzipping"
for fl in $files
do
    dir=$(dirname "${fl}") 
    log "unzipping - $fl to $dir"
    #unzip -v -d $dir $fl
    unzip -o $fl *MCA_APP*Out*.log -d $dir
    rm $fl 
    log "$fl deleted"

done
echo "Collecting log files"
files=`find $initdirname -name *MCA_APP*Out*.log | sort`


log "$files"
total=`echo "$files" | wc -l`
log "total files: $total"

echo "Sending files to $hostname:$hostport"
i=0
for fl in $files
do
	i=$((i+1));
	log  "($i/$total) \t start sending $fl\r"
	servername=$(echo $fl | sed 's#.*/\([^/]*mcafwas[^/]*\).*#\1#')
	appname=$(echo $fl | sed 's#.*/\([^/]*MCA_APP[^/-]*\).*#\1#')

#	 Join next line if not started with date 		
#	 then
#	 add servername and appname to each event
#	 then 
#	 send event and collect result
	cat $fl \
		| awk '/\[[0-9]+\/[0-9]+\/[0-9]+/{if (x)print x;x="";}{x=(!x)?$0:x"##!!NL!!##"$0;}END{print x;}'  \
		| awk -v servappname="$servername $appname " '{ print servappname $0 }' \
		| nc $hostname $hostport; result=$?; 
	#check result
	if [ $result -eq 0 ]; then 
		#if success - delete file
		log "($i/$total) \t $fl was sent successfully\r"
		rm $fl
		log "($i/$total) \t $fl deleted\r"
	else       
		logerr "Something went wrong in sending file $fl, please check connection and try again\r"
	fi

done


echo "Done."
