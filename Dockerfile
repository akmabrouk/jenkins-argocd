FROM python:3.8-slim-buster
WORKDIR /app

# Test network connectivity first
RUN apt-get update && apt-get install -y curl && \
    curl -v https://pypi.org && \
    pip install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]
