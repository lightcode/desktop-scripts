#!/bin/bash

source "$(dirname $0)/shared.sh"

####
# Configuration
####

SOUND_POWERSAVE_BATTERY=1
SOUND_POWERSAVE_AC=0

WIFI_IFNAME="wlp4s0"
WIFI_POWERSAVE_BATTERY="on"
WIFI_POWERSAVE_AC="off"

# ondemand      Dynamically switch between CPU(s) available if at 95% cpu load
# performance   Run the cpu at max frequency
# conservative  Dynamically switch between CPU(s) available if at 75% load
# powersave     Run the cpu at the minimum frequency
# userspace     Run the cpu at user specified frequencies
CPU_GOVERNOR_BATTERY=powersave
CPU_GOVERNOR_AC=ondemand


_usage() {
  echo "Usage: $0 [ac|battery]"
  exit 1
}

_getvalue() {
  eval "echo \$${1}_${mode}"
}

case "$1" in
  ac)      mode="AC" ;;
  battery) mode="BATTERY" ;;
  *)       _usage ;;
esac

if [ $mode == "AC" ]; then
  title="Laptop on the main"
  body="Your laptop is now connected to the main."
  urgency="normal"
else
  title="Laptop on battery"
  body="Your laptop is now disconnected from the main."
  urgency="critical"
fi

exec_all_session "notify-send --urgency=$urgency \"$title\" \"$body\""


# Don't do anything at all
exit



# SOUND
echo $(_getvalue SOUND_POWERSAVE) > /sys/module/snd_hda_intel/parameters/power_save


# CPU
echo $(_getvalue CPU_GOVERNOR) | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null


# WIFI
/usr/sbin/iw dev "$WIFI_IFNAME" set power_save "$(_getvalue WIFI_POWERSAVE)"
