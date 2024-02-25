# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables
ENV TABLEAU_VERSION="2021-4-0"
ENV TABLEAU_DOWNLOAD_URL="https://downloads.tableau.com/esdalt/${TABLEAU_VERSION}/tableau-server-${TABLEAU_VERSION}_amd64.deb"

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Download Tableau Server
RUN wget -q -O tableau-server.deb "$TABLEAU_DOWNLOAD_URL"

# Install Tableau Server
RUN dpkg -i tableau-server.deb

# Initialize and start Tableau Server
RUN tableau-server initialize
RUN tableau-server start

# Wait for Tableau Server to start
RUN sleep 60

# Test if Tableau Server has booted up successfully
RUN if tableau-server status | grep -q "Tableau Server is running"; then \
        echo "Tableau Server has started successfully."; \
    else \
        echo "Error: Tableau Server failed to start."; \
        exit 1; \
    fi

# Expose Tableau Server ports
EXPOSE 80 8850

# Cleanup
RUN rm tableau-server.deb

# CMD ["tail", "-f", "/dev/null"]
