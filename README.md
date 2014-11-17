# Tech-Angels Packer templates

## Boxes description

The current and only template was created for Debian 7.4.0 VM boxes, because this is the default environment at Tech-Angels.
The boxes are "vanilla" with a minimal setup, 256MB RAM, 1 CPU. These settings can be easily changed in vagrant.

## Direct Download

Packaged boxes are available for vmware and virtualbox:

* https://www.dropbox.com/s/t2taop7msj0to2u/packer_virtualbox_virtualbox.box (sha: 55b96389cd2175d91d225dfdfcfece044cc4755b)
* https://www.dropbox.com/s/wezr7ucgxa8tuh8/packer_vmware_vmware.box (sha: 0a512b92202cd6c12d3c2ee91c08b9dc416e325f)

## Prerequisites

* Packer (>= 0.5.0)(http://www.packer.io/downloads.html)
* Vagrant (>= 1.2.4)(http://downloads.vagrantup.com/)
* Vmware or Virtualbox
* Vagrant vmware plugin if you're using vmware (http://www.vagrantup.com/vmware)

### Installing Packer via Homebrew

```bash
$ brew tap homebrew/binary
$ brew install packer
```

## Configure the vagrant box

Edit the ta-debian-7-wheezy.json (or the other one you prefer) and check the variables at the beginning of the file.

*Note*:

The debian iso file name contains the version number and, as soon as a new release will be out and the 770 will be removed from the debian servers, the debian-770-wheezy.json file will be outdated and you'll get the "ISO download failed" error after running the build command.
To fix the issue go on http://cdimage.debian.org/debian-cd/current/amd64/iso-cd/, check which is the latest net-inst version and copy its checksum from the MD5SUMS file. Then edit the .json file and update these variables at the beginning of the .json file:
* "iso_url": update the link to the iso file
* "iso_md5": insert the new MD5 checksum
* "vm_name": update the version

## Build vagrant box

```bash
$ packer build ta-debian-7-wheezy.json
```

or optionnaly, select only one provider, for example ```vmware```:

```bash
$ packer build -only vmware ta-debian-7-wheezy.json
```
*NOTE* Unfortunately Packer has a bug and will not recognize the -only option until [this bug](https://github.com/mitchellh/packer/pull/1402) will be open.

Meanwhile you can use the ta-debian-7-wheezy-virtualbox.json or ta-debian-7-wheezy-virtual-puppet.json instead of ta-debian-7-wheezy.json


### Install your new box

```bash
$ vagrant box add ta-debian-7-wheezy ./packer_vmware-iso_vmware.box
```

or

```bash
$ vagrant box add ta-debian-7-wheezy ./packer_virtualbox-iso_virtualbox.box
```

The VM image has been imported to vagrant, it's now available on your system.

## Vagrant

### Getting Started

To use this image with Vagrant, create a vagrant file (```vagrant init```), and use the newly created box:

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ta-debian-7-wheezy"

  # Make ssh login secure
  # config.ssh.private_key_path = '~/.ssh/id_rsa'
  #
  # [...]
end
```

And initialize the vm:

```bash
$ vagrant up --provider=vmware_fusion
```

The ```--provider``` option is only needed if another vagrant provider is available, like virtualbox.

### Ignore vagrant boxes in git

```bash
$ echo ".vagrant" >> ~/.gitignore
```

## Contributing

1. Fork it
2. Create your recipe branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some features'`)
4. Push to the branch (`git push origin my-new-features`)
5. Create new Pull Request

## Credits

  Many thanks to [Mitchell Hashimoto](https://github.com/mitchellh/) for his awesome work on [Packer](https://github.com/mitchellh/packer) and [Vagrant](https://github.com/mitchellh/vagrant).

  Tech-Angels Inc. - http://www.tech-angels.com/

  [![Tech-Angels](http://media.tumblr.com/tumblr_m5ay3bQiER1qa44ov.png)](http://www.tech-angels.com)
