#!/bin/python3

import sys
from datetime import datetime
import json

with open(sys.argv[1]) as f:
    summary = json.load(f)

# Define the two timestamps
timestamp1 = summary["statusHistory"][0]["stateStartTime"]
timestamp2 = summary["status"]["stateStartTime"]

# Parse the timestamps into datetime objects
fmt = "%Y-%m-%dT%H:%M:%S.%fZ"
time1 = datetime.strptime(timestamp1, fmt)
time2 = datetime.strptime(timestamp2, fmt)

# Calculate the time difference
time_difference = time2 - time1

# Print the result
print("Time difference:", time_difference)
print("Time difference in seconds:", time_difference.total_seconds())

