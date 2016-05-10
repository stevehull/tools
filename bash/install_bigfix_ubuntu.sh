#!/bin/bash
# kickstart bigfix install
# current target - ubuntu
# 
# Usage:
#   wget install_bigfix_ubuntu.sh
#   chmod u+x install_bigfix_ubuntu.sh
#   ./install_bigfix_ubuntu.sh

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

INSTALLDIR="/etc/opt/BESClient"
MASTHEAD="http://_ROOT_OR_RELAY_SERVER_FQDN_:52311/masthead/masthead.afxm"
INSTALLER="http://software.bigfix.com/download/bes/95/BESAgent-9.5.1.9-ubuntu10.amd64.deb"

if [ ! -d "$INSTALLDIR" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir $INSTALLDIR
fi

# Download the BigFix agent
curl -o BESAgent.deb $INSTALLER
# Download the masthead, renamed, into the correct location
curl -o $INSTALLDIR/actionsite.afxm $MASTHEAD

# install BigFix client
dpkg -i BESAgent.deb

# start the BigFix client
/etc/init.d/besclient start
