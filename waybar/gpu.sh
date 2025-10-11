#!/bin/bash

IFS=', ' read -r UTILIZATION TEMPERATURE <<< "$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=noheader,nounits,csv)"

echo "{\"text\": \"$UTILIZATION\", \"tooltip\": \"$TEMPERATURE°C\"}"
