# PowerShell Disk Monitoring Automation Lab for ICT Operations

> A real-world automation lab that monitors disk usage, detects critical conditions, and supports proactive IT operations.

---

## Real-World Scenario

In many IT environments, servers can run out of disk space, causing application failures or service downtime.

This lab simulates a monitoring solution that detects low disk space early and helps prevent system outages.

---

## Overview

This project demonstrates a PowerShell-based disk monitoring solution.

The script checks local disk space, calculates free capacity, classifies disk health status, exports the results to CSV, and writes a log file for tracking and troubleshooting.

---

## Objectives

- Monitor local disk usage  
- Detect warning and critical disk conditions  
- Export results to CSV  
- Write execution logs  
- Practice operational automation  

---

## Tools Used

- PowerShell  
- Windows  
- CSV reporting  
- Log files  
- GitHub documentation  

---

## Folder Structure

```text
powershell-disk-monitoring-lab/
├── README.md
├── scripts/
│   └── Disk-Monitoring.ps1
├── screenshots/
│   ├── 01-folder-structure.png
│   ├── 02-script-view.png
│   ├── 03-script-run.png
│   ├── 04-csv-report.png
│   └── 05-log-file.png
└── docs/
    └── notes.md
```
## How to Run

1. Open PowerShell
2. Navigate to the script folder:
###       cd scripts
  
3. Run the script:
###      Disk-Monitoring.ps1
   
5. Check output:
      - Reports folder for CSV file
      - Logs folder for log file

## Script Logic

The PowerShell script performs the following:

1. Checks local disks
2. Calculates total, used, and free space
3. Calculates free percentage
4. Classifies disk status:
       - Healthy
       - Warning
       - Critical
   
5. Exports the report to CSV
6. Writes execution details to a log file


## Disk Status Logic

    - Healthy: Free space ≥ 20%
    - Warning: Free space < 20%
    - Critical: Free space < 10%

## Sample Output

The CSV report includes:

    - ComputerName
    - DriveLetter
    - TotalSizeGB
    - UsedSpaceGB
    - FreeSpaceGB
    - FreePercent
    - Status
    - CheckedAt

## Screenshots

### Folder Structure
![Folder Structure](screenshots/01-folder-structure.png)

### Script View
![Script View](screenshots/02-powershell-script.png)

### Script Execution
![Script Execution](screenshots/03-script-execution.png)

### CSV Report
![CSV Report](screenshots/04-csv-report.png)

### Log File
![Log File](screenshots/05-log-output.png)


## Practical Impact

This type of monitoring helps:

- Prevent service downtime
- Detect storage issues early
- Support proactive IT operations
- Improve system reliability


## What I Learned

- Automating system monitoring using PowerShell
- Generating structured reports for operational use
- Implementing health classification logic
- Writing logs for troubleshooting and auditing
- Structuring a real-world ICT lab for documentation

## Next Improvements

- Run the script daily with Task Scheduler
- Add alert logic for critical disk space
- Add cleanup for old reports
