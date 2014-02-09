import mutagen
from mutagen.easyid3 import EasyID3


# Provide some application specific keys for file metadata
# It is anticipated that this will be used in pypo/recorder.py
# and the parts of the media monitor that use this.
# The prime motivation is to get rid of the ID3 tag abuse for 
# recorded files so the meta data can be populated more like one would
# want for public consumption

# This should be synchronised with pure.py
# media-monitor2/media/metadata/definitions.py
# media-monitor2/media/monitor/metadata.py
# etc.  This is not ideal

airtime_txxx_fields	=	{
									u"Airtime Recorded": "airtime_recorded",
									u"Airtime Show Name": "airtime_show",
									u"Airtime Show Description": "airtime_description",
									u"Airtime Show Genre":	"airtime_genre",
									u"Airtime Show Who":	"airtime_who",
									u"Airtime Instance Number":	"airtime_show_instance",		
									u"Airtime Show Date": "airtime_show_date",
									u"Airtime Show Time": "airtime_show_time",
								}

for desc, key in airtime_txxx_fields.iteritems():
    EasyID3.RegisterTXXXKey(key, desc)

