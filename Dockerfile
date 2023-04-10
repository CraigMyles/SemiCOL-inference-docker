# Use a base image with Python and CUDA support
FROM nvidia/cuda:11.7.0-base-ubuntu20.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    wget  # Add wget for downloading the model file

# Clone the SemiCOL-inference-docker repository
RUN git clone https://github.com/CraigMyles/SemiCOL-inference-docker.git /app && echo "Cloned the repository"

# Set the working directory
WORKDIR /app

# Install Python dependencies
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Download and decompress the model file into the trained_models folder
# RUN wget -O /app/SemiCOL-inference-docker/trained_models/model.pth https://drive.google.com/uc?export=download&id=1CzHr978FU_XGDW6u_m85sQYcM2jri_mX && git pull

RUN echo "Inside the Dockerfile"
# Copy the entry point script into the container
COPY entrypoint.sh /app
COPY checkpoint_epoch37.pth /app/SemiCOL-inference-docker/trained_models/g4jx4n9k/checkpoint_epoch37.pth

RUN ls -l /app/SemiCOL-inference-docker/trained_models/g4jx4n9k && echo "Inside the Dockerfile"

# Ensure the script is executable
RUN chmod +x /app/entrypoint.sh && git pull && echo "pulled latest version."

# Set the entry point script
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
