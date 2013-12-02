import logging
import time
import sys
import mm2.mm2 as mm2
from std_err_override import LogWriter

global_cfg = '/usr/local/etc/airtime/media-monitor.cfg'
api_client_cfg = '/usr/local/etc/airtime/api_client.cfg'
logging_cfg = '/usr/local/lib/airtime/media-monitor/logging.cfg'

mm2.main( global_cfg, api_client_cfg, logging_cfg )
