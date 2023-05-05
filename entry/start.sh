#!/bin/sh
inv update --no-update-deps
exec supervisord -n -c entry/supervisord.conf
