# AWK
AWK is a **text-processing tool** that reads input line by line, splits it into fields, and lets you **filter, calculate, and format data** easily in one command.

# Examples
1. format Cpu Usage: %

top -bn1 | grep "Cpu(s)" | awk '{print "Cpu Usage: " $2 + $4 "%"}'

# I need memory usage in this format Current Memory: 500MB / Total Memroy: 3658MB (7.22) percentage of usage 

free -m | awk 'NR==2{printf "Current Memory: %sMB / Total Memory: %sMB (%.2f%%)\n",$3,$2,$3*100/$2}'

# Disk Usage

df -h / | awk 'NR==2{printf "Current Disk Usage: "$3" / Total Disk Size: "$2" ("$5") of / file system\n"}'

- awk '{print}' employee.txt --> It prints content in the file
- awk '\manager\ {print}' employee.txt --> It prints matched with manager
- awk '{print $2,$3}' --> print column 2 and 3
- awk '{print NR,$0}' employee.txt --> display with columns
- awk '{print $1,$NF}' employee.txt --> prints first and last column 