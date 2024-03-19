#!/bin/bash
#  -*- coding:UTF-8 -*-:
# #########################:
# Author: Christmas
# Date:
# LastEditTime: 2024-03-19 12:53:27
# Description: Download files from the FTP server
# #########################
# Usage:
#       sh download_from_ftp.sh
#       ./download_from_ftp.sh

usage(){
	echo "############################################################################################################"
    echo -e "         Usage: $0 [OPTIONS]"
	echo -e "         xxxx-xx-xx：	文件后加入日期参数 xxxx-xx-xx，例如：2019-08-01会下载当天的FTP文件。 ."
	echo -e "         all：  			文件后加入*号，会下在所有的FTP文件。默认会覆盖所有文件"
	echo "############################################################################################################"
	exit 1
}

HOST=1.1.1.1  #远程FTP服务器地址
PORT=21
USER=hainan      #远程FTP服务器用户名
PASSWD=123  	#远程FTP服务器密码

REMOTE_DIR=/  				#远程FTP服务器目录
LOCAL_DIR=/home/ocean/zcy/te		#对应的本地服务器目录
LOCAL_DIR_LOG=$LOCAL_DIR/logs		#对应的本地服务器目录

#获取前一天的时间
date1=`date -d last-day +%Y%m%d`
date2=`date -d last-day +%Y-%m-%d`

#date1=`date +%Y%m%d --date="-7 day"`
#date2=`date +%Y-%m-%d --date="-7 day"`


shlog(){
    local line_no msg
    line_no=$1
    msg=$2
    echo "[file_from_ftp.sh][$line_no]["`date "+%Y-%m-%d %H:%M:%S"`"] $msg ">> ${LOCAL_DIR_LOG}/file_from_ftp${date2}.log
}

shlogAllFile(){
    local line_no msg
    line_no=$1
    msg=$2
    echo "[file_all_from_ftp.sh][$line_no]["`date "+%Y-%m-%d %H:%M:%S"`"] $msg ">> ${LOCAL_DIR_LOG}/file_all_from_ftp${date2}.log
}

##下载所有全部文件校验##
function checkFilePros()
{
	echo "%%%%%%%%%%%%%%下载所有全部文件##############%$%%%%%%%%%%%"
	shlogAllFile $LINENO "%%%%%%%%%%%%%%%%%FTP服务器下载所有全部文件%%%%%%%%%%%%%%%%%%%%%%%%"
	let "fileNumFromFtp = 0"
	let "fileNumFromFtpError = 0"

	for file in $LOCAL_DIR/$1
	do
		if test -f $file
		then

			fileName=${file##*/}

			FTPSIZE=`cat $LOCAL_DIR_LOG/tmp_all_from_ftp${date2}.log |sed -n '/'${fileName}'/p' |awk '{print $5}'`
			LOCALSIZE=`ls -l $LOCAL_DIR/${fileName} |awk '{print $5}'`

			echo "%%%%%%%%%%%%%%% ${file##*/} FTPSIZE:==== $FTPSIZE LOCALSIZE:==== $LOCALSIZE"

			if [ "$FTPSIZE" != "" ] && [ "$FTPSIZE" == "$LOCALSIZE" ]; then
				let "fileNumFromFtp+=1"
				shlogAllFile $LINENO "FTP服务器 ${fileName}文件下载到本地 ${file}成功"
			else
				let "fileNumFromFtpError+=1"
				shlogAllFile $LINENO "FTP服务器 ${fileName}文件下载到本地 ${file}失败"
			fi
		fi
	done

	echo "FTP下载的文件成功success个数： $fileNumFromFtp 个数"
	echo "FTP下载的文件失败error个数： $fileNumFromFtpError 个数"
	shlogAllFile $LINENO "FTP下载的文件成功success个数： $fileNumFromFtp 个数"
	shlogAllFile $LINENO "FTP下载的文件失败error个数： $fileNumFromFtpError 个数"

	rm -rf ${LOCAL_DIR_LOG}/tmp_all_from_ftp${date2}.log

}

##下载某一天的文件校验##
function checkFilePros1()
{
	let "fileNumFromFtp = 0"
	let "fileNumFromFtpError = 0"

	for file in $LOCAL_DIR/$1
	do
		if test -f $file
		then
			#echo "%%%%%%%%%%%%%%% ${file##*/}"

			fileName=${file##*/}

			FTPSIZE=`cat $LOCAL_DIR_LOG/tmp_from_ftp${date1}.log |sed -n '/'${fileName}'/p' |awk '{print $5}'`
			LOCALSIZE=`ls -l $LOCAL_DIR/${fileName} |awk '{print $5}'`

			echo "%%%%%%%%%%%%%%% ${fileName} FTPSIZE:==== $FTPSIZE LOCALSIZE:==== $LOCALSIZE"

			if [ "$FTPSIZE" != "" ] && [ "$FTPSIZE" == "$LOCALSIZE" ]; then
				let "fileNumFromFtp+=1"
				shlog $LINENO "FTP服务器 ${fileName}文件下载到本地 ${file}成功"
			else
				let "fileNumFromFtpError+=1"
				shlog $LINENO "FTP服务器 ${fileName}文件下载到本地 ${file}失败"
			fi
		fi
	done

	for file in $LOCAL_DIR/$2
	do
		if test -f $file
		then
			#echo "%%%%%%%*_$date2.csv%%%%%%%% ${file##*/}"

			fileName=${file##*/}

			FTPSIZE=`cat $LOCAL_DIR_LOG/tmp_from_ftp${date2}.log |sed -n '/'${fileName}'/p' |awk '{print $5}'`
			LOCALSIZE=`ls -l $LOCAL_DIR/${fileName} |awk '{print $5}'`

			echo "%%%%%%%%%%%%%%% ${fileName} FTPSIZE:==== $FTPSIZE LOCALSIZE:==== $LOCALSIZE"

			if [ "$FTPSIZE" != "" ] && [ "$FTPSIZE" == "$LOCALSIZE" ]; then
				let "fileNumFromFtp+=1"
				shlog $LINENO "服务器 ${fileName}文件下载到本地 ${file}成功"
			else
				let "fileNumFromFtpError+=1"
				shlog $LINENO "FTP服务器 ${fileName}文件下载到本地 ${file}失败"

			fi

		fi
	done

	echo "FTP下载的文件成功success个数： $fileNumFromFtp 个数"
	echo "FTP下载的文件失败error个数： $fileNumFromFtpError 个数"
	shlog $LINENO "FTP下载的文件成功success个数： $fileNumFromFtp 个数"
	shlog $LINENO "FTP下载的文件失败error个数： $fileNumFromFtpError 个数"


	rm -rf ${LOCAL_DIR_LOG}/tmp_from_ftp${date1}.log
	rm -rf ${LOCAL_DIR_LOG}/tmp_from_ftp${date2}.log
}

function downloadFtpFile()
{
echo "下载FTP存放的本地路径: $LOCAL_DIR"
echo "ftp mutl file start ......"
ftp -v -n $HOST<<EOF
user $USER $PASSWD
binary
cd $REMOTE_DIR
lcd $LOCAL_DIR
prompt
mget $1
ls $REMOTE_DIR$1 ${LOCAL_DIR_LOG}/tmp_all_from_ftp${date2}.log
bye
EOF

checkFilePros $1

#打印环境变量信息
echo "download successfully from ftp all file ending......"
}

function downloadFtpFile1()
{
echo "下载FTP存放的本地路径: $LOCAL_DIR"
echo "ftp mutl file start ......$1 "
echo "ftp mutl file start ......$2 "
matchStr1=$1
matchStr2=$2

ftp -v -n $HOST<<EOF
user $USER $PASSWD
binary
cd $REMOTE_DIR
lcd $LOCAL_DIR
prompt
mget $matchStr1
mget $matchStr2
ls $REMOTE_DIR$1 ${LOCAL_DIR_LOG}/tmp_from_ftp${date1}.log
ls $REMOTE_DIR$2 ${LOCAL_DIR_LOG}/tmp_from_ftp${date2}.log
bye
EOF

checkFilePros1 ${matchStr1} ${matchStr2}

#打印环境变量信息
echo "download successfully from ftp all file ending......"
}

function createFileDir() {
    shlog $LINENO "******************检查待接收下载文件根目录是否存在,不存在则创建该目录************************"
    if [ ! -d ${LOCAL_DIR_LOG} ]; then
        mkdir -p ${LOCAL_DIR_LOG}
    fi
}



echo "Input Param Is [$1]"
if [ ! -n "$1" ] ;then

    shlog $LINENO ""
    shlog $LINENO "*****************************${date2}数据文件下载开始****************************************"

    createFileDir

	echo "###########################################"
	echo " *_${date1}.csv *_${date2}.csv"
	echo "###########################################"

	param1=*_${date1}.csv
	param2=*_${date2}.csv

    downloadFtpFile1 ${param1} ${param2}

	shlog $LINENO "*****************************${date2}数据文件下载结束****************************************"

elif [ -n "$1" ];then
	#echo "这里是指定输入的日期，例如选择要下载一天的文件"

	if echo $1 | grep -Eq "[0-9]{4}-[0-9]{2}-[0-9]{2}" && date -d $1 +%Y%m%d > /dev/null 2>&1
	then
		echo "输入的日期格式正确: $1";
		param1=$1
		echo "######param1#param1###### $param1"
		param2=${param1//-/}
		echo "######param2#param2###### $param2"
		echo "*_${param2}.csv *_${param1}.csv"
        
        shlog $LINENO ""
        shlog $LINENO "*****************************${param1}数据文件下载开始****************************************"
        createFileDir

		downloadFtpFile1 *_${param2}.csv *_${param1}.csv

		shlog $LINENO "*****************************${param1}数据文件下载结束****************************************"

	elif [ $1 == 'all' ];then
		echo "all 下载所有全部文件##############%$%%%%%%........................."
		downloadFtpFile *.csv
   	else
		usage
	fi

else
	echo "这里没有用，永远不会进来的"
fi

exit 0

