#!/bin/bash
set -e

# Install Docker prerequisites
sudo apt-get update -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine + CLI + containerd
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install OCI CLI
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" -- \
    --accept-all-defaults

# Add OCI CLI to PATH
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Get OCIR namespace
NAMESPACE=$(oci os ns get --auth instance_principal --query data --raw-output)
REGION_KEY="sin"

# Fetch OCIR auth token from OCI Vault secret
OCI_AUTH_TOKEN=$(oci secrets secret-bundle get \
  --secret-id ocid1.vaultsecret.oc1.ap-singapore-1.amaaaaaadia3kqiabflgrlqscvc2vnbw2d4wrjhylvp65kcxaajez3h6suiq \
  --auth instance_principal \
  --query "data.\"secret-bundle-content\".content" \
  --raw-output | base64 --decode)

# Docker login to OCIR
echo "${OCI_AUTH_TOKEN}" | sudo docker login ${REGION_KEY}.ocir.io \
-u "${NAMESPACE}/service-user-docker" --password-stdin

# Add cron job (every 2 minutes) for root
(
  sudo crontab -l 2>/dev/null
  echo "*/2 * * * * docker pull sin.ocir.io/ax1h9bph8nyo/fundaztic/prod:latest >> /var/log/fundaztic-scraper.log 2>&1 && docker run --rm sin.ocir.io/ax1h9bph8nyo/fundaztic/prod:latest >> /var/log/fundaztic-scraper.log 2>&1"
) | sudo crontab -

# Ensure cron service is enabled and started
sudo systemctl enable cron
sudo systemctl restart cron
