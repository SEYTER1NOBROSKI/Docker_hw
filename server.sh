#!/bin/sh
echo "Server is listening on port 9090..."
# -l : listen mode
# -k : keep listening after client disconnects
# -p : local port
nc -l -k -p 9090