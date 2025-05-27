#!/bin/bash
# Script to upload credit card data to HDFS and prepare for Superset

# Wait for HDFS to be ready
echo "Waiting for HDFS to be ready..."
until hdfs dfs -ls / > /dev/null 2>&1; do
  sleep 5
done

echo "HDFS is ready. Creating directory structure..."

# Create directory structure in HDFS
hdfs dfs -mkdir -p /data/credit-card-data/
hdfs dfs -mkdir -p /user/hive/warehouse/

# Upload CSV data to HDFS
echo "Uploading credit card data to HDFS..."
hdfs dfs -put -f /data/DataFixABD.csv /data/credit-card-data/

# Create a copy for easy access from Hive
echo "Creating a copy for Hive access..."
hdfs dfs -cp /data/credit-card-data/DataFixABD.csv /user/hive/warehouse/

echo "Data uploaded successfully to HDFS at /data/credit-card-data/DataFixABD.csv"

# Verify data was uploaded
echo "Verifying uploaded data..."
hdfs dfs -ls /data/credit-card-data/
hdfs dfs -ls /user/hive/warehouse/

# Set permissions to ensure access
echo "Setting permissions..."
hdfs dfs -chmod -R 777 /data/credit-card-data/
hdfs dfs -chmod -R 777 /user/hive/warehouse/

echo "HDFS data preparation complete!"
