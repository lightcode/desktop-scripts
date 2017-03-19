#!/bin/bash

exec_all_session() {
  local cmd="$*"

  for username in /home/*; do
    username=$(basename $username)
    (
    local session_file="/home/$username/.dbus/session-bus/$(</var/lib/dbus/machine-id)-0"

    if [[ -f "$session_file" ]]; then
      source "$session_file"

      export DBUS_SESSION_BUS_ADDRESS
      eval export $(grep -z ^DISPLAY /proc/$DBUS_SESSION_BUS_PID/environ)
      su $username -c "$cmd"
    fi
    )
  done
}
