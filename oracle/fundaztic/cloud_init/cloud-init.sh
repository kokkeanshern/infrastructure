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
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

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

docker login ocir.ap-southeast-1.oraclecloud.com

# # Log into OCIR using instance principals
# oci artifacts container login --region ${REGION_KEY}

# # Optionally pull your images
# docker pull ${REGION_KEY}.ocir.io/${NAMESPACE}/fundaztic/prod:latest || true

# # --- Run container (adjust as needed) ---
# docker run -d --name fundaztic-container ${REGION_KEY}.ocir.io/${NAMESPACE}/fundaztic/prod:latest

# # --- Set up cronjob to run python script inside container every hour ---
# echo "0 * * * * docker exec fundaztic-container python /app/my_script.py" >> /var/spool/cron/root
