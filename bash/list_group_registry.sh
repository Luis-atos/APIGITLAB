#!/bin/bash

# 12.2+ only
GROUP_ID="109"
curl -k -H $AUTH -X GET "https://$URI/api/v4/groups/$GROUP_ID/registry/repositories"
