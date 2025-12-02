#!/bin/sh

SERVER_HOST=$1
PORT=9090

echo "Sending data to $SERVER_HOST:$PORT"
echo "Hello from Client Container!" | nc -N $SERVER_HOST $PORT