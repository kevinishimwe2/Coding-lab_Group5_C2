#!/bin/bash

# Showing our menu page
echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Input and their validations
if [[ ! "$choice" =~ ^[1-3]$ ]]; then
    echo "Error: Invalid choice. Please enter 1, 2, or 3."
    exit 1
fi

# Space for making validation based on choice made
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

# File existance checking
if [ ! -f "$log_file" ]; then
    echo "Error: Log file $log_file not found."
    exit 1
fi

# archive directory checking if exists
if [ ! -d "$archive_dir" ]; then
    echo "Error: Archive directory $archive_dir does not exist."
    exit 1
fi

# timestamp making
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")

# filename archiving
archive_file="${archive_dir}/${log_name}_${timestamp}.log"

# log archiving
echo ""
echo "Archiving ${log_name}.log..."

# Moving log files to archive
mv "$log_file" "$archive_file"

if [ $? -ne 0 ]; then
    echo "Error: Failed to archive log file."
    exit 1
fi

# Creating new empty file log
touch "$log_file"

if [ $? -ne 0 ]; then
    echo "Error: Failed to create new log file."
    exit 1
fi

echo "Archived to $archive_file successfully"
