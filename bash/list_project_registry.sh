#!/bin/bash

PROJECT_ID="292"
curl -k -H $AUTH -X GET "https://$URI/api/v4/projects/$PROJECT_ID/registry/repositories"
