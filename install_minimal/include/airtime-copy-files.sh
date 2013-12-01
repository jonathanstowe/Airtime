#!/usr/local/bin/bash -e
#-e Causes bash script to exit if any of the installers
#return with a non-zero return value.

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root user."
    exit 1
fi

#copy files to 
## /usr/local/etc/airtime
#+ /usr/local/etc/apache2/sites-available/airtime
#+ /usr/local/etc/apache2/sites-enabled/airtime
## /usr/local/etc/cron.d/
## /usr/local/etc/init.d/
## /usr/local/etc/monit/conf.d/
# /usr/local/lib/airtime/airtime_virtualenv
## /usr/local/lib/airtime/api_clients
## /usr/local/lib/airtime/media-monitor
# /srv/airtime/stor
## /usr/local/lib/airtime/pypo
## /usr/local/lib/airtime/show-recorder
## /usr/local/lib/airtime/utils
## /usr/local/bin/airtime-*
## /usr/local/share/airtime
## /var/log/airtime
## /var/tmp/airtime

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=`realpath $0`
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=`dirname $SCRIPT`

AIRTIMEROOT=$SCRIPTPATH/../../

echo "* Creating /usr/local/etc/airtime"
mkdir -p /usr/local/etc/airtime
if [ ! -e /usr/local/etc/airtime/airtime.conf ]; then
    #config file airtime.conf exists, but Airtime is not installed
    cp $AIRTIMEROOT/airtime_mvc/build/airtime.conf /usr/local/etc/airtime
fi

#if [ -e /usr/local/etc/airtime/airtime.conf -a "$DO_UPGRADE" -eq "0" ]; then
    #config file airtime.conf exists, but Airtime is not installed
#    mv /usr/local/etc/airtime/airtime.conf airtime.conf.bak
#    cp $AIRTIMEROOT/airtime_mvc/build/airtime.conf /usr/local/etc/airtime
#fi


echo "* Creating /usr/local/etc/monit/conf.d/monit-airtime-generic.cfg"
mkdir -p /usr/local/etc/monit/conf.d/
if [ ! -e /usr/local/etc/monit/conf.d/monit-airtime-generic.cfg ]; then
    rm -f /usr/local/etc/monit/conf.d/*airtime*
    cp $AIRTIMEROOT/python_apps/monit/monit-airtime-generic.cfg /usr/local/etc/monit/conf.d/
fi


echo "* Creating /usr/local/etc/cron.d/airtime-crons"
HOUR=$(($RANDOM%24))
MIN=$(($RANDOM%60))
#echo "$MIN $HOUR * * * root /usr/local/lib/airtime/utils/phone_home_stat" > /usr/local/etc/cron.d/airtime-crons

echo "* Creating /usr/local/lib/airtime"
if [ "$python_service" = "0" ]; then
    echo "doing stuff"
    python $AIRTIMEROOT/python_apps/api_clients/install/api_client_install.py
    
    if [ "$mediamonitor" = "t" ]; then
        echo "doing media nonitor"
        python $AIRTIMEROOT/python_apps/media-monitor/install/media-monitor-copy-files.py
    fi
    if [ "$pypo" = "t" ]; then
        echo "doing pypo"
        python $AIRTIMEROOT/python_apps/pypo/install/pypo-copy-files.py
    fi
fi

cp -R $AIRTIMEROOT/utils /usr/local/lib/airtime
cp -R $AIRTIMEROOT/python_apps/std_err_override /usr/local/lib/airtime

echo "* Creating symbolic links in /usr/local/bin"
#create symbolic links
ln -sf /usr/local/lib/airtime/utils/airtime-import/airtime-import /usr/local/bin/airtime-import
ln -sf /usr/local/lib/airtime/utils/airtime-update-db-settings /usr/local/bin/airtime-update-db-settings
ln -sf /usr/local/lib/airtime/utils/airtime-check-system /usr/local/bin/airtime-check-system
ln -sf /usr/local/lib/airtime/utils/airtime-log /usr/local/bin/airtime-log
ln -sf /usr/local/lib/airtime/utils/airtime-test-soundcard /usr/local/bin/airtime-test-soundcard
ln -sf /usr/local/lib/airtime/utils/airtime-test-stream /usr/local/bin/airtime-test-stream
ln -sf /usr/local/lib/airtime/utils/airtime-silan /usr/local/bin/airtime-silan

echo "* Creating /var/log/airtime"
mkdir -p /var/log/airtime
chmod a+x /var/log/airtime
chown www:www /var/log/airtime/
mkdir -p /var/log/airtime/pypo
chown pypo:pypo /var/log/airtime/pypo
mkdir -p /var/log/airtime/pypo-liquidsoap
chown pypo:pypo /var/log/airtime/pypo-liquidsoap


if [ "$web" = "t" ]; then
    echo "* Creating /usr/local/share/airtime"
    rm -rf "/usr/local/share/airtime"
    mkdir -p /usr/local/share/airtime
    cp -R $AIRTIMEROOT/airtime_mvc/* /usr/local/share/airtime/
    rm -f /usr/local/etc/logrotate.d/airtime-php
    cp $AIRTIMEROOT/airtime_mvc/build/airtime-php.logrotate /usr/local/etc/logrotate.d/airtime-php
fi

echo "* Creating /var/log/airtime"
mkdir -p /var/log/airtime

echo "* Creating /var/tmp/airtime"
mkdir -p /var/tmp/airtime

#Finished copying files
