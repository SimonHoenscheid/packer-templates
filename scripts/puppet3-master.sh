set -e

# Prepare puppetlabs repo
CODENAME=`lsb_release -cs`

wget http://apt.puppetlabs.com/puppetlabs-release-"$CODENAME".deb
dpkg -i puppetlabs-release-"$CODENAME".deb
apt-get update

# Install puppet/facter
apt-get install -y puppet puppetmaster 
rm -f puppetlabs-release-"$CODENAME".deb

# Disable Puppet agent on systemd
# PuppetLabs has the service disabled per default
if which systemctl >/dev/null; then
  systemctl stop puppet
  systemctl disable puppet
  systemctl start puppetmaster
  systemctl enable puppetmaster
fi
