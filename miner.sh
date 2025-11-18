#!/bin/bash

set -a
source miner/.env
set +a

MINER_PROCESS_NAME="score-vision-miner"
MINER_PORT=11200

if pm2 list | grep -q "$MINER_PROCESS_NAME"; then
  echo "Process '$MINER_PROCESS_NAME' is already running. Deleting it..."
  pm2 delete $MINER_PROCESS_NAME
fi

cd miner
pm2 start \
  --name $MINER_PROCESS_NAME \
  -- main:app --host 0.0.0.0 --port $MINER_PORT

# synchronise the process list with the pm2 ecosystem file
pm2 save