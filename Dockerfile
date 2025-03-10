FROM python:3.8-slim-buster

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy entire project
COPY . .

# Set PYTHONPATH to ensure imports work
ENV PYTHONPATH=/app

CMD ["python3", "main.py"]
