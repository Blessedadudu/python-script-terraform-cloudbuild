import logging
import time
import os
from dotenv import load_dotenv

# Load environment variables from .env
load_dotenv()

WELCOME_MESSAGE = os.getenv("WELCOME_MESSAGE", "Yes! Default Welcome Message")
SLEEP_TIME = int(os.getenv("SLEEP_TIME", 5))

def print_welcome():
    while True:
        logging.info(WELCOME_MESSAGE)
        time.sleep(SLEEP_TIME)
