#!/bin/bash

IFS=', ' read -r UTILIZATION TEMPERATURE USED TOTAL <<< "$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=noheader,nounits,csv)"

echo "{\"text\": \"$UTILIZATION\", \"tooltip\": \"$USED of $TOTAL MB\n$TEMPERATURE°C\"}"
