# Bash Examples

Bash Examples expect some variables to be set by default. Add these to your bash profile or set on startup.

## Setup

```bash
# ~/.zshrc or ~/.bashrc
URI="gitlab.meklar.tech"
TOKEN="generated_n_secure"
AUTH="Private-Token: \$TOKEN"
```

## JQ

Using JQ is very helpful in displaying output:

```
curl -X GET -H $AUTH "https://$URI/api/v4/projects" | jq .
```