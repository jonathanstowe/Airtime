import os
import sys
import subprocess

if os.geteuid() != 0:
    print "Please run this as root."
    sys.exit(1)

try:
    #stop pypo and liquidsoap processes
    print "Waiting for Pypo process to stop...",
    try:
        os.remove("/usr/local/bin/airtime-liquidsoap")
    except Exception, e:
        pass
    if (os.path.exists('/usr/local/etc/rc.d/airtime_playout')):
        subprocess.call("/usr/local/etc/rc.d/airtime_playout stop", shell=True)
        print "OK"
    else:
        print "Wasn't running"

    print "Waiting for Liquidsoap process to stop...",
    if (os.path.exists('/usr/local/etc/rc.d/airtime_liquidsoap')):
        subprocess.call("/usr/local/etc/rc.d/airtime_liquidsoap stop", shell=True)
        print "OK"
    else:
        print "Wasn't running"

    subprocess.call("update-rc.d -f airtime-playout remove".split(" "))
    subprocess.call("update-rc.d -f airtime-liquidsoap remove".split(" "))

except Exception, e:
    print e
