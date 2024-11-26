FROM ubuntu:latest

# Install dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
COPY . /app/
WORKDIR /app/

# Create and activate a Python virtual environment
RUN python3 -m venv /venv \
    && . /venv/bin/activate \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --upgrade --requirement Installer

# Add virtual environment to PATH
ENV PATH="/venv/bin:$PATH"

# Run the application
CMD gunicorn app:app & python3 main.py
