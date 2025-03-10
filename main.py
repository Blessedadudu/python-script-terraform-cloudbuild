import logging
import threading
from new.welcome import print_welcome
from new.timeout import main as timeout_main

logging.basicConfig(level=logging.INFO)

if __name__ == "__main__":
    logging.info("Starting all scripts...")

    # Run welcome.py and timeout.py in separate threads
    welcome_thread = threading.Thread(target=print_welcome, daemon=True)
    timeout_thread = threading.Thread(target=timeout_main, daemon=True)

    welcome_thread.start()
    timeout_thread.start()

    # Keep the main thread alive
    welcome_thread.join()
    timeout_thread.join()
