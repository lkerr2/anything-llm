# Team Setup Guide for AnythingLLM

This guide will help you set up AnythingLLM for team collaboration with multi-user authentication and workspace management.

## Quick Start for Teams

### 1. Environment Setup

Copy the team environment template:
```bash
cd docker/
cp .env.team.example .env
```

Edit the `.env` file and set:
- `AUTH_TOKEN`: Your secure admin password (this enables multi-user mode)
- `JWT_SECRET`: A random string at least 32 characters long
- `ANTHROPIC_API_KEY`: Your Anthropic API key (or configure another LLM provider)

### 2. Run with Docker

**Option A: Using pre-built image (recommended)**
```bash
# Create storage directory
export STORAGE_LOCATION=$HOME/anythingllm-team
mkdir -p $STORAGE_LOCATION
cp .env $STORAGE_LOCATION/.env

# Run container
docker run -d -p 3001:3001 --name anythingllm-team \
  --cap-add SYS_ADMIN \
  -v "$STORAGE_LOCATION:/app/server/storage" \
  -v "$STORAGE_LOCATION/.env:/app/server/.env" \
  -e STORAGE_DIR="/app/server/storage" \
  mintplexlabs/anythingllm
```

**Option B: Build from source**
```bash
# Make sure .env is configured first
docker-compose up -d --build
```

### 3. Initial Setup

1. Go to `http://localhost:3001`
2. You'll see a login screen (confirms multi-user mode is active)
3. Enter your `AUTH_TOKEN` password
4. Create your admin account
5. Set up your LLM and embedding preferences

### 4. Team Management

**Creating Users:**
- Go to Admin Settings → Users
- Click "New User"
- Set username, password, and role (Admin, Manager, Default)
- Share credentials with team members

**Creating Workspaces:**
- Go to Workspaces → New Workspace
- Configure workspace-specific settings
- Invite team members to specific workspaces
- Set permissions per workspace

**Roles:**
- **Admin**: Full system access, can manage users and settings
- **Manager**: Can create workspaces and manage team members
- **Default**: Can participate in assigned workspaces

### 5. Production Considerations

**Security:**
- Use strong passwords for `AUTH_TOKEN` and user accounts
- Enable HTTPS for production deployments
- Consider using environment variables instead of `.env` files in production

**Scaling:**
- For larger teams, consider external vector databases (Pinecone, Chroma, etc.)
- Use external LLM providers for better performance
- Monitor resource usage and scale accordingly

**Backup:**
- Regularly backup the storage directory
- Consider database backups for critical data

## Troubleshooting

**Login screen doesn't appear:**
- Verify `AUTH_TOKEN` is set in environment
- Check container logs: `docker logs anythingllm-team`
- Clear browser cache and try incognito mode

**Can't connect to LLM:**
- Verify API keys are correct
- Check network connectivity
- For local services, use `host.docker.internal:PORT` instead of `localhost:PORT`

**Permission issues:**
- Check UID/GID settings in `.env`
- Verify storage directory permissions
- Ensure container has proper capabilities (`--cap-add SYS_ADMIN`)

## Support

For additional help:
- [Official Documentation](https://docs.anythingllm.com/)
- [Discord Community](https://discord.gg/6UyHPeGZAC)
- [GitHub Issues](https://github.com/Mintplex-Labs/anything-llm/issues)