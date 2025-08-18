docker login -u 'instance_principal' sin.ocir.io

docker pull sin.ocir.io/ax1h9bph8nyo/fundaztic/prod:latest

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

NAMESPACE="ax1h9bph8nyo"
REGION_KEY="sin"


echo "Logging into OCIR..."
cat /dev/null | docker login -u 'instance_principal' ${REGION_KEY}.ocir.io --password-stdin

docker pull ${REGION_KEY}.ocir.io/${NAMESPACE}/fundaztic/prod:latest || true

# --- Run container (adjust as needed) ---
docker run -d --name myapp-container ${OCI_REGION}/${NAMESPACE}/${DOCKER_IMAGE}

# --- Set up cronjob to run python script inside container every midnight ---
echo "0 0 * * * docker exec myapp-container python /app/my_script.py" >> /var/spool/cron/root
