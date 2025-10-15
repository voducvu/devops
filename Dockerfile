FROM --platform=linux/arm64 ubuntu:latest

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  unzip \
  git \
  wget \
  software-properties-common \
  && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
  && apt-get update && apt-get install -y terraform

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip aws/

# Set GitHub Personal Access Token (pass as build arg)
ARG GITHUB_PAT
ENV GITHUB_PAT=${GITHUB_PAT}


# Create non-root user
RUN useradd -m -s /bin/bash devuser && \
  usermod -aG sudo devuser && \
  echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER devuser

# Configure git with PAT
RUN git config --global credential.helper store

WORKDIR /workspace

# Create mount point for host configuration files
VOLUME ["/home/devuser"]
CMD ["/bin/bash"]
