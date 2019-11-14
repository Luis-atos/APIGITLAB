#!/bin/bash

PROJECT_ID=311
PAYLOAD='{"ref":"master","variables":[{"key":"PROJECT_VAR","value":"hello there"}]}' 
curl -X POST -H $AUTH "https://$URI/api/v4/projects/$PROJECT_ID/pipeline" -H "Content-Type: application/json" -d "$PAYLOAD"