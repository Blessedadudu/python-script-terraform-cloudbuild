import logging
import time
import os
import threading
import google.cloud.logging
from dotenv import load_dotenv
from welcome import print_welcome  # Import the welcome function

# Load environment variables
load_dotenv()

SLEEP_TIME = int(os.getenv("SLEEP_TIME", 5))

def main():
    logging.basicConfig(level=logging.INFO)

    if int(os.getenv("PRODUCTION", 0)) == 1:
        logging_client = google.cloud.logging.Client()
        logging_client.setup_logging()

    # Start welcome.py function in a separate thread
    threading.Thread(target=print_welcome, daemon=True).start()

    while True:
        logging.info("Sleeping for %d seconds", SLEEP_TIME)
        time.sleep(SLEEP_TIME)

if __name__ == "__main__":
    main()
