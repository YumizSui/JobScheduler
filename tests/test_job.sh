#!/usr/bin/env bash

mkdir -p tmp
paramA=$1
paramB=$2
OUTPUT_FILE="tmp/output_${paramA}_${paramB}"

echo "Started job with paramA=$paramA, paramB=$paramB"

echo "Sleeping for 30 seconds..."
sleep 30

echo "Finished job with paramA=$paramA, paramB=$paramB"
touch $OUTPUT_FILE
echo $OUTPUT_FILE > $OUTPUT_FILE

echo "Output file created at: $OUTPUT_FILE"
