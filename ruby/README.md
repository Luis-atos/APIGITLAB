# Gitlab API Gem

## Install

```
git clone git@gitlab.com:davinwalker/gitlab-api-examples.git
cd gitlab-api-examples/ruby

# This will install required gems
bundle install
```

## Usage

These examples use environment variables (GITLAB_URL, GITLAB_TOKEN) to configure authentication. 

You can either specifcy them in your environment or create a `.env` file which the gem `dotenv` will load when using these examples.

```
# .env
GITLAB_URL='https://gitlab/api/v4'
GITLAB_TOKEN='private_token'
```

```
GITLAB_URL='https://gitlab/api/v4' GITLAB_TOKEN='private_token' ./active_users.rb


export GITLAB_URL='https://gitlab/api/v4'
export GITLAB_TOKEN='private_token'
./active_users.rb
```


## Links
* [Gitlab Gem](https://github.com/NARKOZ/gitlab)
  * [Reference](https://www.rubydoc.info/gems/gitlab)