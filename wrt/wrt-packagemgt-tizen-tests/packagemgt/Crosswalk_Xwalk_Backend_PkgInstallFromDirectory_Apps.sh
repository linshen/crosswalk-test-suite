#!/bin/bash
#
# Copyright (C) 2010 Intel Corporation
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# Author:
# 
path=$(cd $(dirname $0);pwd)
PACKAGENAME=$path/../testapp/"web_app_test.wgt"
get_uninstall_status=`pkgcmd -u -n webapptest -q`
get_install_status=`pkgcmd -i -t wgt -p $PACKAGENAME -q`
get_install_status=` echo $get_install_status | awk '{print $15}'`
echo $get_install_status
sleep 1
if [[ "$get_install_status" =~ "val[ok]" ]];then
     get_backend_status=`/usr/lib/xwalk/xwalk_backend -i $path/../testapp/ 2>&1`
     if [[ "$get_backend_status" =~ "Cannot install from directory" ]];then
        echo "Installation from directory is unsupported, ok"
        sleep 1
        get_uninstall_status=`pkgcmd -u -n webapptest -q`
        exit 0
     else
        echo "Installation from directory is supported, fail"
        exit 1
     fi
else
  echo "install fail"
  exit 1
fi
