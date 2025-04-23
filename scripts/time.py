#!/bin/python3

from datetime import datetime

# Define the two timestamps
timestamp1 = "2025-04-23T08:42:04.359896Z"
timestamp2 = "2025-04-23T08:42:28.221787Z"

# Parse the timestamps into datetime objects
fmt = "%Y-%m-%dT%H:%M:%S.%fZ"
time1 = datetime.strptime(timestamp1, fmt)
time2 = datetime.strptime(timestamp2, fmt)

# Calculate the time difference
time_difference = time2 - time1

# Print the result
print("Time difference:", time_difference)
print("Time difference in seconds:", time_difference.total_seconds())

