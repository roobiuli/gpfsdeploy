#!/bin/bash

## Author Robert I.N.
## Purpose :
# The script is responsible in creating an chef solo env by installing ruby and chef-solo also setting up the recipe on which chef 
#solo will construct the vagrant two node cluster
# Things wich will be installed 1 Repo 2 Vagrant 3 Virtualbox  4 Ruby 5 Chef - Solo 



function exists {
	[ ! -f $1 ]
}

## Key package needed for interrogation



#### Install / verify Remi repo 
exists /etc/yum.repos.d/remi.repo

if [ $? -eq 0 ]
then 

echo "Installing remi repo "
#RVERS=`lsb_release -a | grep "Release" | awk '{print $2 }' | cut -d"." -f1`
RVERS=`cat /etc/issue | grep release | grep -o [0-9] | head -n 1`
 yum install -y wget vim

wget http://rpms.famillecollet.com/enterprise/remi-release-$RVERS.rpm

 rpm -Uvh remi*.rpm ; rm -rf *.rpm

#ENABLE REMI REPO
sed -i.backup -e s'/enable=0/enable=1/g' /etc/yum.repos.d/remi.repo

else 
	echo "Remi Repo found .. Moving to Package installs"
fi


#### 

##Install vagrant and VBOX

exists /usr/bin/virtualbox
	if [ $? -eq 0 ]
		then
			echo "Iinstalling Virtualbox.."
			cd /etc/yum.repos.d/
			wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
			cd ~/
			yum install VirtualBox-5.1.x86_64 -y 
		else 
			echo "Virtualbox found .. Doing nothing"
		fi

exists /usr/bin/vagrant
	if [ $? -eq 0 ]
		then
		echo "Installing Vagrant..."
		wget https://releases.hashicorp.com/vagrant/1.8.6/vagrant_1.8.6_x86_64.rpm
		rpm -Uvh vagrant*.rpm
		rm -rf vagrant*.rpm
	else 
		echo "Vagrant found ... doing nothing"
	fi





##
#yum install install ruby


ruby -v 

if [ $? -ne 0 ]
	then
		echo "Installing ruby and chef-solo"
		yum install ruby -y && curl -L https://www.opscode.com/chef/install.sh | bash
	else
		echo "Ruby found .. Probing for chef-solo"
		exists /usr/bin/chef-solo

		if [ $? -ne 0 ]
			then
			echo "Installing Chef"
			curl -L https://www.opscode.com/chef/install.sh | bash
		else 
			"Nothing to do.. Please review if Chef-Solo and ruby are installed"
		fi
	fi





