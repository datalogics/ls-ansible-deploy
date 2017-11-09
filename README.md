# Deploying SimplyE with Ansible

## Deploy a New Server

1. Copy `vars/circulation-settings.template` to `vars/circulation-settings.yml`.

2. Edit the new .yml file, filling in every field marked (REQUIRED). The other fields may be changed if needed, but the values already present should be good enough in most cases.

3. Run the command `ansible-playbook -vv -i localhost circulation-server.yml`. You can make the output more or less verbose by adding or removing v's to the "-vv" flag.

4. Sit back and wait. Starting up a new RDS database will take a while.

## Update an Existing Server

1. Use the same `circulation-settings.yml` file you used when you deployed the new server.

2. The only things that should be changed are the Docker fields, usually just version tags.

3. Run the command `ansible-playbook -vv -i localhost circulation-update.yml`.

4. It shouldn't take more than a few seconds. The final step will be to reboot the EC2 machine, so in a few minutes you can SSH to it and confirm that the updates have been applied.
