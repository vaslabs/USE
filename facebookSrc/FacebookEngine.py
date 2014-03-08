#!/usr/bin/python
# coding: utf-8

import FacebookConfig
import facebook
import urllib
import urlparse
import subprocess
import warnings
import json
import operator

def getMusic( uid="me()" ) :

  try :
    #Token got by selecting app_name from the drop-down list.
    query = "SELECT music FROM user WHERE uid=\"" + str(uid) + "\""
    params = urllib.urlencode({'q': query, 'access_token': FacebookConfig.long_lived_access_token})
    url = "https://graph.facebook.com/fql?" + params
    data = urllib.urlopen(url).read()#string json format
    
    output=[]
    jdata = json.loads( data )
    for d in jdata['data']:
      for key, value in d.iteritems():
        songs=value.split(', ')
        output.extend( songs )
#        for song in songs:
#          print song
    return output
  except facebook.GraphAPIError as e:
    print 'Something went wrong:', e.type, e.message
    
songA = getMusic( "61400799" )
songB = getMusic( "1560456312" )
songC = getMusic( "1204511935" )

songA.extend( songB )
songA.extend( songC )
print songA

resultList = {}
for song in songA :
  if song not in resultList :
    resultList[song]=0
  else :
    resultList[song]=resultList[song] + 1

commonFirst = sorted(resultList.iteritems(), key=operator.itemgetter(1))
print commonFirst
