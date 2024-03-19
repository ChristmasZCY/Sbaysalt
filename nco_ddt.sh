#!/bin/bash
#  -*- coding:UTF-8 -*-: 
# #########################: 
# Author: Christmas
# Date: 2024-01-18 16:05:43
# LastEditTime: 2024-03-19 12:53:27
# Description: Cycle through the files in the specified directory, extract the specified variables, and merge them into a single file
# #########################
# Usage:
#       sh nco_ddt.sh
#       sh nco_ddt.sh > log.txt 2>&1
#       nohup sh nco_ddt.sh > log.txt 2>&1 &
#       ./nco_ddt.sh
# ==============================================================================================================
#                                       Settings
# ==============================================================================================================
# InputDir: The directory where the original file is located
DIR_IN='/home/ocean/ForecastSystem/FVCOM_Global_v2/Run'
# OutputDir: The directory where the processed file is located
DIR_OUT='/home/ocean/ForecastSystem/FVCOM_Global_v2/Run'
# suffix: The suffix of the output file
suffix='uv'
# ddt_1: Start date
ddt_1='20231208'
# ddt_2: End date
ddt_2='20240118'
# vars: The variables to be extracted
vars='lonc,latc,nv,u,v,Times,Itime,Itime2'
# CAT: Whether to merge the extracted files into a single file
CAT=1
# DEL: Whether to delete the extracted files
DEL=1
# ==============================================================================================================
# ==============================================================================================================

time_start=`date -d $ddt_1 +%s`
time_end=`date -d $ddt_2 +%s`
while [ $time_start -le $time_end ]
do
    date=`date -d @$time_start +%Y%m%d`
    if [ -f ${DIR_IN}/${date}/output/forecast_0001.nc ]; then
        echo $date
        ncks -v ${vars} ${DIR_IN}/${date}/output/forecast_0001.nc -O ${DIR_OUT}/${date}_{suffix}.nc
    fi
    time_start=$((time_start+86400))
done
if [ $CAT -eq 1 ]; then
    ncrcat ${DIR_OUT}/*_{suffix}.nc ${DIR_OUT}/{suffix}.nc
fi
if [ $DEL -eq 1 ]; then
    rm ${DIR_OUT}/*_uv.nc
fi
