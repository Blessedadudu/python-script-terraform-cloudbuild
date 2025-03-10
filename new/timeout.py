import logging
import time
import google.cloud.logging
import os

def main():
    logging.basicConfig(level=logging.INFO)
    
    if int(os.environ.get("PRODUCTION", 0)) == 1:
        logging_client = google.cloud.logging.Client()
        logging_client.setup_logging()

    while True:
        logging.info("!!!!!Check if allowed to change! Sleeping for 5 seconds")
        time.sleep(5)
