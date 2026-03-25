FROM ghcr.io/openclaw/openclaw:main

USER root

# Install common development and testing tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    python3 \
    python3-pip \
    python3-venv \
    jq \
    vim \
    net-tools \
    iputils-ping \
    rsync \
    && rm -rf /var/lib/apt/lists/*

# Add any additional skills/integrations dependencies here
# For example, if you need a specific version of a tool or additional libraries

# Switch back to the node user (as used in the base image)
USER node

# Create a default workspace directory if it doesn't exist
RUN mkdir -p /home/node/.openclaw/workspace

# Ensure workspace is available for skills development
WORKDIR /home/node/.openclaw/workspace

# Default command remains the same as base image or customized if needed
CMD ["node", "/app/dist/index.js", "gateway", "run"]
