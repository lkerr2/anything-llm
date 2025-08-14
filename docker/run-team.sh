#!/bin/bash

# AnythingLLM Team Setup Script
# This script sets up AnythingLLM for team collaboration using the pre-built Docker image

set -e

echo "🚀 Setting up AnythingLLM for Team Collaboration"
echo "================================================"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Create storage directory
STORAGE_DIR="$HOME/anythingllm-team"
echo "📁 Creating storage directory: $STORAGE_DIR"
mkdir -p "$STORAGE_DIR"

# Copy environment file if it doesn't exist
if [ ! -f "$STORAGE_DIR/.env" ]; then
    echo "⚙️  Setting up environment configuration..."
    cp .env.team.example "$STORAGE_DIR/.env"
    
    # Update the API key placeholder if available
    if [ -n "${ANTHROPIC_API_KEY}" ]; then
        sed -i.bak "s/sk-ant-your-api-key-here/${ANTHROPIC_API_KEY}/" "$STORAGE_DIR/.env"
        rm "$STORAGE_DIR/.env.bak" 2>/dev/null || true
        echo "✅ Environment file created with API key"
    else
        echo "✅ Environment file created at $STORAGE_DIR/.env"
        echo "💡 Edit the .env file and add your ANTHROPIC_API_KEY"
    fi
else
    echo "⚙️  Using existing environment file at $STORAGE_DIR/.env"
fi

# Stop existing container if running
if docker ps -q -f name=anythingllm-team | grep -q .; then
    echo "🛑 Stopping existing AnythingLLM team container..."
    docker stop anythingllm-team
    docker rm anythingllm-team
fi

# Run the container
echo "🐳 Starting AnythingLLM team container..."
docker run -d \
    --name anythingllm-team \
    -p 3002:3001 \
    --cap-add SYS_ADMIN \
    -v "$STORAGE_DIR:/app/server/storage" \
    -v "$STORAGE_DIR/.env:/app/server/.env" \
    -e STORAGE_DIR="/app/server/storage" \
    -e AUTH_TOKEN="TeamSecurePassword2024!" \
    -e JWT_SECRET="anythingllm-jwt-secret-key-2024-team-workspace-auth" \
    -e JWT_EXPIRY="30d" \
    --restart unless-stopped \
    mintplexlabs/anythingllm

echo ""
echo "🎉 AnythingLLM Team Setup Complete!"
echo "=================================="
echo ""
echo "🌐 Access your team instance at: http://localhost:3002"
echo "🔐 Admin password: Check your .env file for AUTH_TOKEN"
echo "💾 Data stored in: $STORAGE_DIR"
echo ""
echo "📚 Next Steps:"
echo "  1. Go to http://localhost:3002"
echo "  2. Login with your admin password"
echo "  3. Create user accounts for your team"
echo "  4. Set up workspaces for collaboration"
echo ""
echo "🔧 Container Management:"
echo "  • View logs: docker logs anythingllm-team"
echo "  • Stop: docker stop anythingllm-team"
echo "  • Start: docker start anythingllm-team"
echo ""
echo "📖 For more help, see: docker/TEAM_SETUP.md"