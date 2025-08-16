#!/bin/bash
set -e

NAMESPACE="ax1h9bph8nyo"

# --- Vars from Terraform (injected via user_data) ---
OCI_USERNAME="${oci_username}"
OCI_REGION=sin.ocir.io
OCI_AUTH_TOKEN="${oci_auth_token}"
DOCKER_IMAGE="${docker_image}"

# --- Install Docker ---
yum update -y
yum install -y docker
systemctl enable docker
systemctl start docker

# --- Login to OCIR ---
docker login ${OCI_REGION} \
  -u "${NAMESPACE}/${OCI_USERNAME}" \
  -p "${OCI_AUTH_TOKEN}"

# --- Pull image ---
docker pull ${OCI_REGION}/${NAMESPACE}/${DOCKER_IMAGE}

# --- Run container (adjust as needed) ---
docker run -d --name myapp-container ${OCI_REGION}/${NAMESPACE}/${DOCKER_IMAGE}

# --- Set up cronjob to run python script inside container every midnight ---
echo "0 0 * * * docker exec myapp-container python /app/my_script.py" >> /var/spool/cron/root
