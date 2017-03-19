#!/bin/bash

source "$(dirname $0)/shared.sh"

SCRIPT="/usr/local/bin/screen-hotplug"

exec_all_session "$SCRIPT $opts"
