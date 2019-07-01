#!/bin/sh

if [ -n "$(env | grep 'DEPLOY_KEY')" ]; then
    echo "Calling SSH Agent"
    eval $(ssh-agent -s);
    [ -n "$GITLAB_DEPLOY_KEY" ] && echo "$GITLAB_DEPLOY_KEY" | ssh-add - || true;
    [ -n "$RUNNER_DEPLOY_KEY" ] && echo "$RUNNER_DEPLOY_KEY" | ssh-add - || true;
    [ -n "$SERVER_DEPLOY_KEY" ] && echo "$SERVER_DEPLOY_KEY" | ssh-add - || true;
fi

if [ ! -d $HOME/.ssh ]; then
    mkdir $HOME/.ssh
    echo -e "UserKnownHostsFile /dev/null\nStrictHostKeyChecking no" > $HOME/.ssh/config
fi

exec "$@"
