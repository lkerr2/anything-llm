# AnythingLLM Team Quick Start Guide

This guide will help you and Lily set up AnythingLLM for team collaboration.

## 🚀 For Lily (or any team member) to get started:

### 1. Clone the Team Fork
```bash
git clone https://github.com/lkerr2/anything-llm.git
cd anything-llm
git checkout team-setup-config
```

### 2. Set up API Key (Required)
```bash
# Set your Anthropic API key (ask Sydney for the key)
export ANTHROPIC_API_KEY="your-anthropic-api-key-here"
```

### 3. Run the Team Setup
```bash
cd docker
chmod +x run-team.sh
./run-team.sh
```

### 4. Access AnythingLLM
- Open your browser and go to: **http://localhost:3002**
- Enter the admin password: **TeamSecurePassword2024!**

## 📋 What the setup script does:
- Creates storage directory at `~/anythingllm-team/`
- Sets up environment with team authentication
- Runs Docker container on port 3002
- Configures Anthropic Claude as the LLM provider

## 👥 Team Management

### Initial Admin Setup (First Time):
1. Login with password: `TeamSecurePassword2024!`
2. Complete the initial setup wizard
3. Go to Admin Settings → Users
4. Create accounts for team members

### Creating Team Members:
1. Click "New User" 
2. Set username and password
3. Choose role:
   - **Admin**: Full system access
   - **Manager**: Can create workspaces and manage users  
   - **Default**: Can use assigned workspaces

### Setting up Workspaces:
1. Go to Workspaces → New Workspace
2. Name your workspace (e.g., "Project Alpha", "Research Team")
3. Configure LLM settings for the workspace
4. Invite team members to specific workspaces

## 🔧 Container Management Commands:
```bash
# View logs
docker logs anythingllm-team

# Stop the container
docker stop anythingllm-team

# Start the container  
docker start anythingllm-team

# Restart with fresh setup
./run-team.sh
```

## 🛠 Troubleshooting:

**Can't access localhost:3002?**
- Make sure Docker is running
- Check if container is running: `docker ps | grep anythingllm`
- Try a hard refresh (Cmd+Shift+R or Ctrl+Shift+R)

**Login not working?**
- Password is: `TeamSecurePassword2024!` (case sensitive)
- Try clearing browser cache
- Use incognito/private browsing mode

**Port already in use?**
- The script uses port 3002 to avoid conflicts
- If needed, you can modify the port in `run-team.sh`

## 📞 Support:
- Team repository: https://github.com/lkerr2/anything-llm/tree/team-setup-config
- Original docs: https://docs.anythingllm.com/