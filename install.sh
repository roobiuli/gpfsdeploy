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
sudo yum install -y wget vim

wget http://rpms.famillecollet.com/enterprise/remi-release-$RVERS.rpm

sudo rpm -Uvh remi*.rpm ; rm -rf *.rpm

#ENABLE REMI REPO
sed -i.backup -e s'/enable=0/enable=1/g' /etc/yum.repos.d/remi.repo

else 
	echo "Remi Repo found .. Moving to Package installs"
fi


#### 

##Install vagrant and VBOX

exists /usr/bin/virtualbox
	if [ $? -eq 0]
		then
			wget -o /etc/yum.repos.d/virtualbox.repo http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
		else 
			echo "Virtualbox found .. Doing nothing"
		fi

exists /usr/bin/vagrant
	if [ $? -eq 0]
		then
		wget https://releases.hashicorp.com/vagrant/1.8.6/vagrant_1.8.6_x86_64.rpm
		rpm -Uvh vagrant*.rpm
	else 
		echo "Vagrant found ... doing nothing"
	fi





##
#yum install install ruby








