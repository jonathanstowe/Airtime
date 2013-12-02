import subprocess
import os
import sys

if os.geteuid() != 0:
    print "Please run this as root."
    sys.exit(1)

try:
    print "Waiting for media-monitor processes to stop...",
    if (os.path.exists('/usr/local/etc/rc.d/airtime_media_monitor')):
        subprocess.call("/usr/local/etc/rc.d/airtime_media_monitor stop", shell=True)
        print "OK"
    else:
        print "Wasn't running"

    subprocess.call("update-rc.d -f airtime-media-monitor remove".split(" "))
except Exception, e:
    print e
