FROM ubuntu:latest
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    # Add these lines to your Dockerfile
WORKDIR /app/

# Create a virtual environment
RUN python3 -m venv /app/venv

# Activate the virtual environment and install dependencies
RUN /app/venv/bin/pip install --no-cache-dir --upgrade --requirement Installer

# Specify the entrypoint to use the virtual environment's Python
CMD /app/venv/bin/python3 main.py

COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir --upgrade --requirement Installer
CMD gunicorn app:app & python3 main.py
