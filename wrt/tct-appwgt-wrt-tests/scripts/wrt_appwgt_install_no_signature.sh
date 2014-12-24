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
#        Zhang Ge <gex.zhang@intel.com>
#        Mengli Zhang <mengli.zhang@samsung.com>

function existbh()
{
  echo $1
  pkgcmd -u -q -t wgt -n bWcMjcFmQF
  exit $2
}
$(dirname $0)/wrt_appwgt_installer.sh sp-widget-no-signature.wgt bWcMjcFmQF
if [ $? -ne 0 ]
then
  exit 1
fi
app_launcher -s bWcMjcFmQF.spWidgetNoSignature
sleep 2
widgetpath="/home/app/.config/xwalk-service/applications/bWcMjcFmQF.spWidgetNoSignature"
if [ ! -d $widgetpath ]
then
  existbh "The path of the application does not exist." 1
fi
filecount=$(ls -lR $widgetpath|grep "^-"|wc -l)
name=("config.xml" "icon.png" "index.html")
if [ $filecount -eq 3  ]
then
  filename=$(ls $widgetpath)
  for var in ${filename[@]};do
    echo ${name[@]}|grep -q "$var"
    if [ $? -ne 0 ]
    then
      existbh "WRT does not support Web AppWidget installation." 1
    fi
  done
  indexcount=$(find $widgetpath -name index.html|wc -l)
  if [ $indexcount -ne 1  ]
  then
    existbh "WRT does not support Web AppWidget installation." 1
  fi
  existbh "WRT supports Web AppWidget installation." 0
else
  existbh "WRT does not support Web AppWidget installation." 1
fi
