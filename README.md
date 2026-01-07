# Unraid Docker Management Init

## Setup Instructions

1. **Setup SSH agent and add key:**
   ```bash
   eval "$(ssh-agent)"
   ssh-add
   ```

2. **Initialize folders on Unraid:**
   ```bash
   ./init
   ```

3. **Deploy Portainer to Unraid:**
   ```bash
   DOCKER_HOST="ssh://root@192.168.50.6" docker-compose up -d
   ```