FROM python:3.12-slim

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir --upgrade --requirement Installer

CMD ["gunicorn", "app:app", "&", "python3", "main.py"]
