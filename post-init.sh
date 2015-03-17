#!/usr/bin/env bash

###############################################################################
# Constants
###############################################################################
wp_version="{{wpVersion}}"

###############################################################################
# Helper functions
###############################################################################
function check_exit_status {
    if [ $? -eq 0 ]; then
        echo "    ...done."
    else
        echo "    ...failed."
        exit 1;
    fi
}

###############################################################################
# Logic
###############################################################################
# Create git repo
echo "Creating  git repo..."
git init &> /dev/null
check_exit_status


# Get WordPress
wp_archive="wordpress-${wp_version}.tar.gz"
if [ ! -f "/tmp/${wp_archive}" ]; then
    echo "Downloading WordPress version ${wp_version}..."
    curl -o "/tmp/${wp_archive}" -L "http://wordpress.org/${wp_archive}"
    check_exit_status
else
    echo "Using WordPress version ${wp_version} found in /tmp."
fi

# Unpack WordPress into the local directory
echo "Unpacking WordPress..."
tar -zxf "/tmp/${wp_archive}" -C "website" > /dev/null
check_exit_status

# Commit all the files
echo "Creating the initial commit..."
git add --all && git commit -m "Initial commit" > /dev/null
check_exit_status

###############################################################################
