#!/usr/bin/env bash
set -ex
/usr/local/bin/supervisorctl -c /usr/local/supervisor/etc/integration-supervisor.conf stop all
pkill supervisord
