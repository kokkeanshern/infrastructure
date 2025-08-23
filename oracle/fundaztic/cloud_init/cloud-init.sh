#!/bin/bash
set -e

# Install Docker
apt-get update -y
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    python3-pip

# Add Docker’s official GPG key
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y

# Install Docker Engine + CLI + containerd
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" -- \
    --accept-all-defaults

echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Get OCIR namespace
NAMESPACE=$(oci os ns get --auth instance_principal --query data --raw-output)
REGION_KEY="sin"

OCI_AUTH_TOKEN=$(oci secrets secret-bundle get \
  --secret-id ocid1.vaultsecret.oc1.ap-singapore-1.amaaaaaadia3kqiabflgrlqscvc2vnbw2d4wrjhylvp65kcxaajez3h6suiq \
  --auth instance_principal \
  --query "data.\"secret-bundle-content\".content" \
  --raw-output | base64 --decode)

echo "${OCI_AUTH_TOKEN}" | docker login ${REGION_KEY}.ocir.io \
-u "${NAMESPACE}/service-user-docker" --password-stdin

# # Optionally pull your images
docker pull ${REGION_KEY}.ocir.io/${NAMESPACE}/fundaztic/prod:latest || true

# # --- Run container (adjust as needed) ---
docker run -d --name fundaztic-container ${REGION_KEY}.ocir.io/${NAMESPACE}/fundaztic/prod:latest

# # --- Set up cronjob to run python script inside container every hour ---
# echo "0 * * * * docker exec fundaztic-container python /app/my_script.py" >> /var/spool/cron/root
