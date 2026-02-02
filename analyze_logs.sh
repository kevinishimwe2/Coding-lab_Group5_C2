#!/bin/bash

# Promting the user to select 
echo "Select log file to analyze:"
echo "1) Heart Rate (heart_rate_log.log)"
echo "2) Temperature (temperature_log.log)"
echo "3) Water Usage (water_usage_log.log)"
read -p "Enter choice (1-3): " choice

# check input 
if [[ ! "$choice" =~ ^[1-3]$ ]]; then
    echo "Error: Invalid choice. Please enter 1, 2, or 3."
    exit 1
fi

# choose the log file and device pattern
case $choice in
    1)
        log_file="hospital_data/active_logs/heart_rate_log.log"
        log_type="Heart Rate"
        device_pattern="Monitor-"
        ;;
    2)
        log_file="hospital_data/active_logs/temperature_log.log"
        log_type="Temperature"
        device_pattern="Sensor-"
        ;;
    3)
        log_file="hospital_data/active_logs/water_usage_log.log"
        log_type="Water Usage"
        device_pattern="Water-Meter"
        ;;
esac

# Check if log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: Log file $log_file not found."
    exit 1
fi

# Check if log file is empty
if [ ! -s "$log_file" ]; then
    echo "Error: Log file $log_file is empty."
    exit 1
fi

# Verify existence of reports folder 
mkdir -p hospital_data/reports

# Generate report
report_file="hospital_data/reports/analysis_report.txt"
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo "" >> "$report_file"
echo "========================================" >> "$report_file"
echo "Analysis Report - $log_type" >> "$report_file"
echo "Generated: $timestamp" >> "$report_file"
echo "========================================" >> "$report_file"
# categorize by log type

if [ "$choice" == "3" ]; then
	# Water meter has only one device

	count=$(grep -c "$device_pattern" "$log_file")
	first_entry=$(grep "$device_pattern" "$log_file" | head -1 | awk '{print $1, $2}')
    	last_entry=$(grep "$device_pattern" "$log_file" | tail -1 | awk '{print $1, $2}')
	echo "" >> "$report_file"
	echo "Device: Water-Meter" >> "$report_file"
	echo "  Total entries: $count" >> "$report_file"
	echo "  First entry: $first_entry" >> "$report_file"
	echo "  Last entry: $last_entry" >> "$report_file"
else
	# Heart rate and temperature have multiple devices
	devices=$(grep -oP "${device_pattern}\K[0-9]+" "$log_file" | sort -u)
	for device_id in $devices; 
	do
		device_name="${device_pattern}${device_id}"
		count=$(grep -c "$device_name" "$log_file")
		first_entry=$(grep "$device_name" "$log_file" | head -1 | awk '{print $1, $2}')
		last_entry=$(grep "$device_name" "$log_file" | tail -1 |  awk '{print $1, $2}')

		echo "" >> "$report_file"
		echo "Device: $device_name" >> "$report_file"
		echo "  Total entries: $count" >> "$report_file"
		echo "  First entry: $first_entry" >> "$report_file"
		echo "  Last entry: $last_entry" >> "$report_file"
	done
fi

echo "" >> "$report_file"
echo "Analysis complete. Results appended to $report_file"
echo ""

cat "$report_file" | tail -20
