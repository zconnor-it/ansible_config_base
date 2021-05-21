# ansible_config_base

## Purpose
To make a quick and easy Ansible control node for testing and playing. This includes:
- Setting up a user with remote acces
- Setting up ssh keys
- Passwordless escalation
- Root privs

## Assumptions
- Root accounts with the same password exist on all the clients
- Security is not a consideration

## Instructions
1. Modify the inventory file to include the systems you would like to manage with ansible
2. Execute the deploy.sh script with elevated privs. EX: "sudo sh deploy.sh"
3. Enter requested information
4. Change directory to the newly created ansible directory in the users home dir. EX: cd /home/<NEW_USER>/ansible
5. Enjoy a simple base ansible configuration
