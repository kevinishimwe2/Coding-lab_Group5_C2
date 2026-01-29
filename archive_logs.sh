#!/bin/bash

# Display menu
echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Validate input
if [[ ! "$choice" =~ ^[1-3]$ ]]; then
    echo "Error: Invalid choice. Please enter 1, 2, or 3."
    exit 1
fi

# Set variables based on choice
case $choice in
    1)
        log_name="heart_rate"
        log_file="hospital_data/active_logs/heart_rate_log.log"
        archive_dir="hospital_data/archived_logs/heart_data_archive"
        display_name="Heart Rate"
        ;;
    2)
        log_name="temperature"
        log_file="hospital_data/active_logs/temperature_log.log"
        archive_dir="hospital_data/archived_logs/temperature_data_archive"
        display_name="Temperature"
        ;;
    3)
        log_name="water_usage"
        log_file="hospital_data/active_logs/water_usage_log.log"
        archive_dir="hospital_data/archived_logs/water_usage_data_archive"
        display_name="Water Usage"
        ;;
esac

# Check if log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: Log file $log_file not found."
    exit 1
fi

# Check if archive directory exists
if [ ! -d "$archive_dir" ]; then
    echo "Error: Archive directory $archive_dir does not exist."
    exit 1
fi

# Generate timestamp
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

# Archive filename
archive_file="${archive_dir}/${log_name}_${timestamp}.log"

# Archive the log
echo ""
echo "Archiving ${log_name}.log..."

# Move the log file to archive
mv "$log_file" "$archive_file"

if [ $? -ne 0 ]; then
    echo "Error: Failed to archive log file."
    exit 1
fi

# Create new empty log file
touch "$log_file"

if [ $? -ne 0 ]; then
    echo "Error: Failed to create new log file."
    exit 1
fi

echo "Successfully archived to $archive_file"
echo ""

