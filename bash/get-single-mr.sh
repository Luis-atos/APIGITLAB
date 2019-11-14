#!/bin/bash

PROJECT_ID=4
MR_IID=1
curl -X GET -H $AUTH "https://$URI/api/v4/projects/$PROJECT_ID/merge_requests/$MR_IID"