#!/usr/bin/python
# coding: utf-8
from facepy.utils import get_extended_access_token
import facebook

app_id = XXXXXXX
app_secret = 'XXXXXX'
short_lived_access_token = "XXXXXX" #get this from https://developers.facebook.com/tools/explorer/ by selecting the application and pasting the long token
try :
    long_lived_access_token, expires_at = get_extended_access_token(
            short_lived_access_token,
            app_id, app_secret)
      
except facebook.GraphAPIError as e:
    print 'Something went wrong:', e.type, e.message
