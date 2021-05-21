#!/bin/bash
# Read input from user
echo "Enter the name of the user you would like to create and use to remote into other systems"
read REMOTE_USER
echo "Enter a passphrase for the ssh key. If you would like to leave it blank, press enter"
read PASSPHRASE
useradd $REMOTE_USER
echo "WHEN PROMPTED, Enter a password for the new local user. This will NOT be added to the remote systems"
passwd $REMOTE_USER

# Ensure that new users home has a .ssh directory
mkdir /home/$REMOTE_USER/.ssh/

# Generate ssh key and move it to the $REMOTE_USERs home
ssh-keygen -f id_rsa -P "$PASSPHRASE"
mv id_rsa.pub /home/$REMOTE_USER/.ssh/
mv id_rsa /home/$REMOTE_USER/.ssh/
chown -R $REMOTE_USER:$REMOTE_USER /home/$REMOTE_USER/.ssh

# Create a temp vars file for ansible playbook
echo "---" >> vars.yml
echo "- deploy_remote_user: $REMOTE_USER" >> vars.yml

# Run ansible playbook
echo "WHEN PROMPTED, Enter the root password for the systems you are deploying to"
ansible-playbook deploy.yml --ask-pass

# Clean up vars.yml
rm vars.yml

mkdir /home/$REMOTE_USER/ansible
cp ansible.cfg /home/$REMOTE_USER/ansible
cp inventory /home/$REMOTE_USER/ansible
chown -R $REMOTE_USER:$REMOTE_USER /home/$REMOTE_USER/ansible


echo "You may now log in as $REMOTE_USER."
echo "A directory called ansible has been created in $REMOTE_USER's home directory."
echo "It contains the inventory file from the git working directory and a simple ansible.cfg."
