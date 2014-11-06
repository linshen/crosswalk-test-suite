#!/bin/bash
#Copyright (c) 2013 Intel Corporation.
#
#Redistribution and use in source and binary forms, with or without modification,
#are permitted provided that the following conditions are met:
#
#* Redistributions of works must retain the original copyright notice, this list
#  of conditions and the following disclaimer.
#* Redistributions in binary form must reproduce the original copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#* Neither the name of Intel Corporation nor the names of its contributors
#  may be used to endorse or promote products derived from this work without
#  specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION BE LIABLE FOR ANY DIRECT,
#INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
#OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
#EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#Authors:
#
local_path=$(cd "$(dirname $0)";pwd)
path=$(dirname $(dirname $0))
PACKAGENAME="3d_test.wgt"
source $path/stablonglast3d/xwalk_common.sh
APP_NAME="3d_test"
SLEEP=86400
uninstall_app $APP_NAME
install_app $PACKAGENAME
launch_app $APP_NAME
$local_path/Generatesysmon.sh $SLEEP `(basename $0)` $appid &
sleep 2
if [[ "$launch_statue" =~ "launched" ]];then
   sleep 86400
   get_app_statu=`app_launcher -r thrdoptest.twodframeplaytest`
   if [[ "$get_app_statu" =~ "running" ]];then
       app_launcher -k thrdoptest.twodframeplaytest
   else
       exit 1
   fi
else
    exit 1
fi
