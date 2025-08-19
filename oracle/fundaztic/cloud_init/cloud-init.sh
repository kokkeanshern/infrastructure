#!/bin/bash
set -e

# Install Docker
yum update -y
yum install -y docker
systemctl enable docker
systemctl start docker

# Install OCI CLI (if not already installed)
if ! command -v oci &> /dev/null; then
    bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)" -- \
        --accept-all-defaults
    echo "export PATH=\$PATH:/root/bin" >> /root/.bashrc
    export PATH=$PATH:/root/bin
fi

# Get OCIR namespace
NAMESPACE=$(oci os ns get --query data --raw-output)

# Region short code (replace with your region, e.g. sin, iad, fra, nrt)
REGION_KEY="sin"

# Log into OCIR using instance principals
oci artifacts container login --region ${REGION_KEY}

# Optionally pull your images
docker pull ${REGION_KEY}.ocir.io/${NAMESPACE}/fundaztic/prod:latest || true

# --- Run container (adjust as needed) ---
docker run -d --name fundaztic-container ${REGION_KEY}.ocir.io/${NAMESPACE}/fundaztic/prod:latest

# --- Set up cronjob to run python script inside container every hour ---
echo "0 * * * * docker exec fundaztic-container python /app/my_script.py" >> /var/spool/cron/root
