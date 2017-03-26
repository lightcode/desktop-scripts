install-udev-common:
	install -m 0755 -o root -g root -d /opt/udev-scripts
	install -m 0644 -o root -g root udev-common/shared.sh /opt/udev-scripts

install-screen: install-udev-common
	install -m 0755 -o root -g root screen/cycle-screen /usr/local/bin
	install -m 0755 -o root -g root screen/switch-screen /usr/local/bin
	install -m 0644 -o root -g root screen/screen-hotplug.rules /etc/udev/rules.d
	install -m 0755 -o root -g root screen/udev-screen-hotplug.sh /opt/udev-scripts

install-power-source: install-udev-common
	install -m 0644 -o root -g root power-source/power-source.rules /etc/udev/rules.d
	install -m 0755 -o root -g root power-source/udev-power-source.sh /opt/udev-scripts


install: install-screen install-power-source
