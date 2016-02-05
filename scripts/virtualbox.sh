set -e

if test -f .vbox_version ; then
  # The netboot installs the VirtualBox support (old) so we have to remove it
  if test -f /etc/init.d/virtualbox-ose-guest-utils ; then
    /etc/init.d/virtualbox-ose-guest-utils stop
  fi

  if lsmod | grep vboxguest; then
    rmmod vboxguest
  fi
  aptitude -y purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms virtualbox-ose-guest-utils

  # Install dkms for dynamic compiles
  apt-get install -y dkms

  # If libdbus is not installed, virtualbox will not autostart
  apt-get -y install --no-install-recommends libdbus-1-3

  # Install the VirtualBox guest additions
  mount -o loop VBoxGuestAdditions.iso /mnt
  yes|sh /mnt/VBoxLinuxAdditions.run || true # ignoring error due to missing Xorg
  umount /mnt
  #rm -f VBoxGuestAdditions.iso

  # Start the newly build driver
  service vboxadd start
fi
