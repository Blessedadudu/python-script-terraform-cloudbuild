FROM python:3.8-slim-buster

WORKDIR /app

# Copy and install dependencies
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy entire project
COPY . .

# Set PYTHONPATH to ensure imports work
ENV PYTHONPATH=/app

# Set environment variables (these will be overridden by build args)
ARG WELCOME_MESSAGE
ARG SLEEP_TIME
ARG PRODUCTION

ENV WELCOME_MESSAGE=${WELCOME_MESSAGE}
ENV SLEEP_TIME=${SLEEP_TIME}
ENV PRODUCTION=${PRODUCTION}

CMD ["python3", "main.py"]
