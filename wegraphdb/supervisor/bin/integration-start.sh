#!/usr/bin/env bash
set -ex
nohup /usr/local/bin/supervisord -c /usr/local/supervisor/etc/integration-supervisor.conf > /usr/local/supervisor/logs/integration-supervisor-start.log 2>&1 &
