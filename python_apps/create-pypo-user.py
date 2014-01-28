import os
import sys
from subprocess import Popen, PIPE, STDOUT

def create_user(username):
  print "* Checking for user "+username

  p = Popen('id '+username, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
  output = p.stdout.read()

  if (output[0:3] != "uid"):
    # Make the pypo user
    print " * Creating user "+username
    os.system("pw useradd "+username)
  else:
    print "User already exists."
  
  primary_group="pypo"
  supplementary_groups=['audio', 'www', 'pulse']

  os.system("pw groupadd " + primary_group + " 1>/dev/null 2>&1")

  for group in supplementary_groups:
     os.system("pw groupadd " + group + " 1>/dev/null 2>&1")

  group_list = ",".join(supplementary_groups)

  os.system("pw usermod " + username + " -g " + primary_group + " -G " + group_list + " 1>/dev/null 2>&1")

if __name__ == "__main__":
    if os.geteuid() != 0:
        print "Please run this as root."
        sys.exit(1)

    create_user("pypo")
