#!/bin/bash
if [ ! -d "./VirtualEnv" ]; then
  virtualenv VirtualEnv
fi
source ./VirtualEnv/bin/activate
pip install -r requirements.txt

#Write vault pwd in local file
echo "Please enter Keychain Password"
read -s vaultpwd
echo $vaultpwd > /tmp/.vaultpwd

#Write AWS environment variables
AWS_SECRET=$(./crypted/vault_keys.py secret_key)
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET}
AWS_ACCESS=$(./crypted/vault_keys.py access_key)
export AWS_ACCESS_KEY_ID=${AWS_ACCESS}

#exemple
alias stage-create-node='ansible-playbook create_playbook.yml -i inventory/prod --vault-password-file /tmp/.vaultpwd --tags create'