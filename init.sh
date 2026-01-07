#!/bin/bash

# Arcane Docker Setup - Remote Directory Initialization Script
# This script creates required directories on the remote Unraid server via SSH

set -e

# Configuration
REMOTE_HOST="root@[YOUR_UNRAID_IP]"
SSH_KEY="~/.ssh/[YOUR_SSH_KEY]"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Unraid Appdata Directory Initialization ===${NC}\n"

# Check if SSH key exists
if [ ! -f "${SSH_KEY/#\~/$HOME}" ]; then
    echo -e "${RED}Error: SSH key not found at ${SSH_KEY}${NC}"
    echo "Please update the SSH_KEY variable in this script."
    exit 1
fi

# Test SSH connection
echo -e "${YELLOW}Testing SSH connection to ${REMOTE_HOST}...${NC}"
if ! ssh -i "${SSH_KEY}" -o ConnectTimeout=5 "${REMOTE_HOST}" "echo 'Connection successful'" > /dev/null 2>&1; then
    echo -e "${RED}Error: Cannot connect to ${REMOTE_HOST}${NC}"
    echo "Please verify:"
    echo "  1. The remote host IP address is correct"
    echo "  2. SSH key is added to ssh-agent: ssh-add ${SSH_KEY}"
    echo "  3. The remote host is accessible"
    exit 1
fi
echo -e "${GREEN}✓ SSH connection successful${NC}\n"

# Create directories on remote host
echo -e "${YELLOW}Creating directories on remote host...${NC}"

DIRECTORIES=(
    "/mnt/user/appdata/portainer-ce/data"
)
for DIR in "${DIRECTORIES[@]}"; do
    echo -e "Creating ${DIR}..."
    ssh -i "${SSH_KEY}" "${REMOTE_HOST}" "mkdir -p ${DIR} && chmod 755 ${DIR}"
    echo -e "${GREEN}✓ ${DIR} created${NC}"
done

echo -e "\n${GREEN}=== Initialization Complete ===${NC}"
echo -e "\nNext steps:"
echo -e "  1. Update environment variables in docker-compose.yml"
echo -e "  2. Deploy with: DOCKER_HOST=\"ssh://${REMOTE_HOST}\" docker-compose up -d"
