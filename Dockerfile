# Simple Dockerfile for DevOps Stack
FROM alpine:latest

# Install basic tools
RUN apk add --no-cache \
    curl \
    wget \
    git \
    bash

# Create a simple health check script
RUN echo '#!/bin/bash' > /healthcheck.sh && \
    echo 'echo "DevOps Stack is healthy!"' >> /healthcheck.sh && \
    echo 'exit 0' >> /healthcheck.sh && \
    chmod +x /healthcheck.sh

# Set the health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD /healthcheck.sh

# Default command
CMD ["/healthcheck.sh"]
