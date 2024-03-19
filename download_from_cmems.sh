#!/bin/bash
#  -*- coding:UTF-8 -*-:
# #########################:
# Author: Christmas
# Date:
# LastEditTime: 2024-03-19 12:53:27
# Description: Download files from CMEMS
# #########################
# Usage:
#       sh download_from_cmems.sh
#       ./download_from_cmems.sh
# ==============================================================================================================
#                                       Settings
# ==============================================================================================================
# Output directory
outdir="/home/USER/Documents"
# Product and dataset IDs
serviceId="SST_GLO_SST_L4_REP_OBSERVATIONS_010_011-TDS"
productId="METOFFICE-GLO-SST-L4-REP-OBS-SST"
# Coordinates
lon=(-65 -57)   #longitude
lat=(11 19)     #latitude
# Date initialization
startDate=$(date -d "2008-01-01" +%Y-%m-%d)
endDate=$(date -d "2008-01-05" +%Y-%m-%d)
# Variables
variable=("analysed_sst" "analysis_error")
# time step
addDays=1
# Whether to use MOTU
MOTU=1
# ==============================================================================================================
# ==============================================================================================================

endDate=$(date -d "$endDate + $addDays days" +%Y-%m-%d)

# Time range loop
while [[ "$startDate" != "$endDate" ]]; do

    echo "=============== Date: $startDate ===================="

    if [ $MOTU -eq 0 ]; then
        command="copernicus-marine subset -i $productId \
        -v ${variable[0]} -v ${variable[1]} \
        -x ${lon[0]} -X ${lon[1]} -y ${lat[0]} -Y ${lat[1]} \
        -t \"$startDate\" -T \"$startDate\" \
        --force-download -o $outdir -f sst_med_$(date -d "$startDate" +%Y-%m-%d).nc"
    elif [ $MOTU -eq 1 ]; then
        query="python -m motuclient --motu https://my.cmems-du.eu/motu-web/Motu --service-id $serviceId --product-id $productId \
        --longitude-min ${lon[0]} --longitude-max ${lon[1]} \
        --latitude-min ${lat[0]} --latitude-max ${lat[1]} \
        --date-min \"$startDate\" --date-max \"$startDate\" \
        --variable ${variable[0]}  --variable ${variable[1]} "

    command="copernicus-marine subset --motu-api-request \" $query \" --force-download -o $outdir -f sst_med_$(date -d "$startDate" +%Y-%m-%d).nc"

    fi
    echo -e "$command \n============="
    eval "$command"

    startDate=$(date -d "$startDate + $addDays days" +%Y-%m-%d)

done

echo "=========== Download completed! ==========="
