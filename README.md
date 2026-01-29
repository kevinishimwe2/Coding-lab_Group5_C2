#our first group work
# Hospital Monitoring System

## Directory Structure
```
hospital_data/
├── active_logs/
│   ├── heart_rate.log
│   ├── temperature.log
│   └── water_usage.log
├── heart_data_archive/
├── temperature_archive/
└── water_archive/

reports/
└── analysis_report.txt
```

## Setup and Initialization

### 1. Start the Monitoring Devices
Run each simulator in a separate terminal:

```bash
# Terminal 1 - Heart Rate Monitor
python3 heart_monitor.py start

# Terminal 2 - Temperature Sensor
python3 temp_sensor.py start

# Terminal 3 - Water Meter
python3 water_meter.py start
```

### 2. Verify Data Collection
```bash
# Watch heart rate logs
tail -f hospital_data/active_logs/heart_rate.log

# Watch temperature logs
tail -f hospital_data/active_logs/temperature.log

# Watch water usage logs
tail -f hospital_data/active_logs/water_usage.log
```

## Task 1: Archive Logs Script

### Usage
```bash
./archive_logs.sh
```

### Features
- Interactive menu to select log type
- Archives log with timestamp
- Creates new empty log for continued monitoring
- Error handling for invalid inputs and missing files

### Example
```bash
$ ./archive_logs.sh
Select log to archive:
1) Heart Rate
2) Temperature
3) Water Usage
Enter choice (1-3): 1

Archiving heart_rate.log...
Successfully archived to hospital_data/heart_data_archive/heart_rate_2024-06-18_15:22:10.log
```

## Task 2: Analyze Logs Script

### Usage
```bash
./analyze_logs.sh
```

### Features
- Interactive menu to select log type
- Counts device occurrences
- Records first and last entry timestamps
- Appends results to reports/analysis_report.txt

### Example
```bash
$ ./analyze_logs.sh
Select log file to analyze:
1) Heart Rate (heart_rate.log)
2) Temperature (temperature.log)
3) Water Usage (water_usage.log)
Enter choice (1-3): 1

Analysis complete. Results appended to reports/analysis_report.txt
```

## Testing

### Generate Test Data
Let the simulators run for 1-2 minutes to generate sample data, then:

1. Test archiving:
   ```bash
   ./archive_logs.sh
   ```

2. Test analysis:
   ```bash
   ./analyze_logs.sh
   ```

3. Check archived files:
   ```bash
   ls -lh hospital_data/heart_data_archive/
   ls -lh hospital_data/temperature_archive/
   ls -lh hospital_data/water_archive/
   ```

4. View analysis report:
   ```bash
   cat reports/analysis_report.txt
   ```

## Stopping Simulators
Press `Ctrl+C` in each terminal running the Python simulators.

