#!/bin/bash
get_arch=$(uname -a)
get_phcpu=$(cat /proc/cpuinfo | grep "physical id" |wc -l)
get_vcpu=$(cat /proc/cpuinfo | grep "processor" |wc -l)
get_mem_usage=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }')
get_dis_usage=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)", $3,$2,$5}')
get_cpu_load=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
get_lb=$(who -b | awk '{print $3" "$4" "$5}')
get_lvm=$(lsblk |grep lvm | awk '{if ($1) {print "yes";exit} else {print "no"} }')
get_co_tcp=$(echo -n $(ss -s | grep 'TCP:' | cut -d '(' -f 2 | cut -d ',' -f 1 | cut -d ' ' -f 2); echo "  ESTABLISHED")
get_usr_log=$(users | wc -w)
get_ip=$(hostname -I)
get_mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
get_sudo=$(grep 'sudo ' /var/log/auth.log | wc -l)
wall "  #Architecture: $get_arch
        #CPU physical: $get_phcpu
        #vCPU: $get_vcpu
        #Memory Usage: $get_mem_usage
        #Disk Usage: $get_dis_usage
        #CPU load: $get_cpu_load
        #Last boot: $get_lb
        #LVM use: $get_lvm
        #Connection TCP: $get_co_tcp
        #User log: $get_usr_log
        #Network: IP $get_ip $get_mac
        #Sudo: $get_sudo cmd"
