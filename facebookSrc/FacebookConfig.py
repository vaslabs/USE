#!/usr/bin/python
# coding: utf-8
from facepy.utils import get_extended_access_token
import facebook

app_id = 294242907396048
app_secret = 'b123ce2b1161c2f6747e5a401adefc49'
short_lived_access_token = "CAAELnMP5F9ABACmjpyKvIk66KtYAZC3TvHzZBbyO39AkH0MIqdVQiKPnGzS7YeAT0D44GyZCPUpH0cZCjLN2cf8hj0CPWRF04ZCssBLZAAq6KZBo3aBHseYZBPYQSX0KdsX2JkYqB35VEkvSgzyQFxC6zGvtkStSEj8Wif40oHhbKY6T2Agb0jju0XeMNZBv21xUZD"
try :
    long_lived_access_token, expires_at = get_extended_access_token(
            short_lived_access_token,
            app_id, app_secret)
      
except facebook.GraphAPIError as e:
    print 'Something went wrong:', e.type, e.message
