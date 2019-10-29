#---------------------------------------------------------------------
# Function: InstallISPConfig
#    Start the ISPConfig3 installation script
#---------------------------------------------------------------------
InstallISPConfig() {
  echo "Installing ISPConfig3... "
  cd /tmp
  if [ "$CFG_ISPCVERSION" == "Beta" ]; then
	wget -q -O ISPConfig-3.1-beta.tar.gz https://git.ispconfig.org/ispconfig/ispconfig3/repository/archive.tar.gz
	tar xfz ISPConfig-3.1-beta.tar.gz
	cd ispconfig3_install*
	cd install
  else
	wget -q https://www.ispconfig.org/downloads/ISPConfig-3-stable.tar.gz
	tar xfz ISPConfig-3-stable.tar.gz
	cd ispconfig3_install/install/
  fi
    php -q install.php
  if [ $CFG_SETUP_WEB == "yes" ]; then
    if [ "$CFG_WEBSERVER" == "nginx" ]; then
        echo -n "Restarting nginx... "
        /etc/init.d/nginx restart
    elif [ "$CFG_WEBSERVER" == "apache" ]; then
        echo -n "Restarting Apache... "
        /etc/init.d/apache2 restart
    fi
	echo -e "[${green}DONE${NC}]\n"
  fi

}
