#!/usr/bin/env bash

################################################################################
# Vagrant LAMP server provisioning script
#
# This script is designed to be used in conjunction with Vagrant
# to create and configure a LAMP server VM.
################################################################################

################################################################################
# Settings (Modify these values to customize your setup.)
################################################################################
# MySQL
MYSQL_ROOT_PASSWD="vagrant"
MYSQL_DB_NAME="{{wpDbName}}"
MYSQL_USERNAME="{{wpDbUser}}"
MYSQL_USER_PASSWD="{{wpDbPassword}}"

# Apache
APACHE_VHOST_FILENAME="apache_vhost"
APACHE_ENABLE_REWRITE=true

# Default Vagrant shared folder
VAGRANT_SHARE_PATH="/vagrant"

# Website install paths
DEFAULT_SITE_PATH="/var/www/html"
INSTALLED_SITE_PATH="/opt/website"

# User settings
APACHE_USER="www-data"
VM_USER="vagrant"

################################################################################
# Helper functions
################################################################################
function echo_done_or_failed {
    if [ $? -eq 0 ]; then
        echo "   ...done."
    else
        echo "   ...failed."
    fi
}

################################################################################
# Preparation
################################################################################
echo "Updating package cache..."
apt-get update -qq
echo_done_or_failed

################################################################################
# MySQL
################################################################################

# Preseed answers for the MySQL install.
debconf-set-selections <<EOF
mysql-server-5.5 mysql-server/root_password password $MYSQL_ROOT_PASSWD
mysql-server-5.5 mysql-server/root_password_again password $MYSQL_ROOT_PASSWD
EOF

echo "Installing MySQL..."
apt-get install -qq -y mysql-server
echo_done_or_failed


# Create database.
if [ ! -z "$MYSQL_DB_NAME" ]; then
    echo "Creating database $MYSQL_DB_NAME..."
    mysql -u root -p"$MYSQL_ROOT_PASSWD" <<EOF
CREATE DATABASE $MYSQL_DB_NAME;
EOF
    echo_done_or_failed
fi

# Create user.
if [ ! -z "$MYSQL_USERNAME" ]; then
    echo "Creating database user $MYSQL_USERNAME..."
    mysql -u root -p"$MYSQL_ROOT_PASSWD" <<EOF
CREATE USER '$MYSQL_USERNAME'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWD';
EOF
    echo_done_or_failed

    echo "Creating database user permissions..."
    mysql -u root -p"$MYSQL_ROOT_PASSWD" <<EOF
GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USERNAME'@'localhost';
EOF
    echo_done_or_failed
fi

################################################################################
# Apache
################################################################################
echo "Installing Apache..."
apt-get install -qq -y apache2
echo_done_or_failed

# Use customized vhost.
if [ ! -z "$APACHE_VHOST_FILENAME" ]; then
    cp "$VAGRANT_SHARE_PATH/vm-config/$APACHE_VHOST_FILENAME" /etc/apache2/sites-available/000-default.conf
    a2ensite "000-default"
fi

# Enable mod_rewrite
if $APACHE_ENABLE_REWRITE ; then
    echo "Enabling Apache rewrite module..."
    a2enmod rewrite
    service apache2 restart
    echo_done_or_failed
fi

################################################################################
# PHP
################################################################################
echo "Installing PHP..."
apt-get install -qq -y php5 libapache2-mod-php5
apt-get install -qq -y php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl
echo_done_or_failed

################################################################################
# Site Setup
################################################################################
# Use symlinks to map custom files into the correct locations.
rm -rf "$DEFAULT_SITE_PATH"
ln -s "$INSTALLED_SITE_PATH" "$DEFAULT_SITE_PATH"

# Permissions
usermod -aG "$APACHE_USER" "$VM_USER"
chown -R "root:root" "$INSTALLED_SITE_PATH"
chown -R "$APACHE_USER:$APACHE_USER" "$INSTALLED_SITE_PATH/wp-content"
chown -R "$APACHE_USER:$APACHE_USER" "$INSTALLED_SITE_PATH/.htaccess"

# Restart apache
service apache2 restart

