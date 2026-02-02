# Hospital Log Management System

Automated log management system for patient health metrics and resource usage monitoring.

## Overview

This system provides:
- **Real-time data collection** from patient health monitors and resource meters
- **Interactive log archiving** with timestamp-based organization
- **Analytical reports** with device statistics and temporal patterns

## Directory Structure

```
hospital_data/
├── active_logs/                    # Current log files
│   ├── heart_rate.log              # Format: TIMESTAMP DEVICE VALUE
│   ├── temperature.log
│   └── water_usage.log
├── archived_logs/                  # Archived data
│   ├── heart_data_archive/
│   ├── temperature_data_archive/
│   └── water_usage_data_archive/
└── reports/
    └── analysis_report.txt
```

## Python Simulators

### Heart Rate Monitor
Simulates 2 heart rate monitors generating readings between 60-120 bpm.

```bash
python3 heart_monitor.py start   # Start monitoring
python3 heart_monitor.py stop    # Stop monitoring
```

### Temperature Sensor
Simulates 2 temperature sensors generating readings between 36.0-39.5°C.

```bash
python3 temp_sensor.py start
python3 temp_sensor.py stop
```

### Water Meter
Simulates a water meter generating usage readings in liters.

```bash
python3 water_meter.py start
python3 water_meter.py stop
```

## Shell Scripts

### archive_logs.sh

Interactive script to archive log files with timestamps.

```bash
./archive_logs.sh
```

**Features:**
- Interactive menu to select log type (1-3)
- Moves active log to designated archive folder under `archived_logs/`
- Renames with timestamp: `{type}_YYYY-MM-DD_HH:MM:SS.log`
- Creates new empty log for continued monitoring
- Error handling for missing files and directories

### analyze_logs.sh

Interactive script to analyze log files and generate reports.

```bash
./analyze_logs.sh
```

**Features:**
- Interactive menu to select log file
- Counts device occurrences  
- Records first/last entry timestamps
- Calculates min/max/average values
- Appends results to `reports/analysis_report.txt`

## Quick Start

```bash
# 1. Start all monitors
python3 heart_monitor.py start
python3 temp_sensor.py start
python3 water_meter.py start

# 2. Wait for data collection
sleep 5

# 3. Verify logs are being generated
tail -f hospital_data/active_logs/heart_rate.log

# 4. Archive a log file
./archive_logs.sh

# 5. Analyze a log file
./analyze_logs.sh

# 6. View the analysis report
cat hospital_data/reports/analysis_report.txt

# 7. Stop all monitors
python3 heart_monitor.py stop
python3 temp_sensor.py stop
python3 water_meter.py stop
```

## Files

| File | Description |
|------|-------------|
| `heart_monitor.py` | Heart rate monitor simulator |
| `temp_sensor.py` | Temperature sensor simulator |
| `water_meter.py` | Water usage meter simulator |
| `archive_logs.sh` | Interactive log archival script |
| `analyze_logs.sh` | Log analysis and reporting script |

