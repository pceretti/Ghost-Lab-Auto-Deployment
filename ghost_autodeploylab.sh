#!/bin/bash

cat <<EOF > ghostconfig.yml
ludus:
  - vm_name: "{{ range_id }}-GHOST-API"
    hostname: "{{ range_id }}-GHOST-API"
    template: rocky-9-x64-server-template
    vlan: 10
    ip_last_octet: 100
    ram_gb: 4
    cpus: 2
    linux: true
    testing:
      snapshot: false
      block_internet: false
EOF

# Setting up the battalions with ludus range command
ludus range config set -f ghostconfig.yml

# Deploying the legions
ludus range deploy

# Function to consult the Red Priests for deployment status
check_status() {
    status=$(ludus range status | grep "SUCCESS")
    if [ -z "$status" ]; then
        return 1
    else
        return 0
    fi
}

# Waiting for ravens to return with news of successful deployment
while ! check_status; do
    echo "Deployment is not yet successful. Waiting..."
    sleep 60  # Adjust sleep time as needed
done

# Rejoice! The deployment has succeeded, let's update the lords of the servers
