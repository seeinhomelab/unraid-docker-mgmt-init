# Unraid Docker Management Init

## Setup Instructions

1. **Setup SSH agent and add key:**
   ```bash
   eval "$(ssh-agent)"
   ssh-add ~/.ssh/<private-ssh-key>
   ```

2. **Initialize folders on Unraid:**
   ```bash
   nano init.sh
   chmod +x init.sh
   ./init.sh
   ```

3. **Deploy Portainer to Unraid:**
   ```bash
   DOCKER_HOST="ssh://root@[unraid-ip]" docker-compose up -d
   ```
