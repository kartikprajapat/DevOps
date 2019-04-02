#!/bin/bash

export MAIL=<mail ids>

# In MBs
export CONTAINER_RAM_UTIL_LIMIT=50

# In number of Cores
export CONTAINER_CPU_UTIL_LIMIT=0.01

# In Percentage
export MACHINE_RAM_USAGE_LIMIT=50

#In Percentage
export MACHINE_CPU_USAGE_LIMIT=5
docker ps -a | awk '{print $1}'| sed "1 d" | while read -r container_id ; do


export CONTAINER_CPU_UTILIZATION=$(docker stats $container_id --no-stream | awk 'NR == 2 {print $3}' | sed 's/%.*//')
export CONTAINER_RAM_UTILIZATION=$(docker stats $container_id --no-stream | awk 'NR == 2 {print $4}' | sed 's/MiB.*//')
export CONTAINER_RUNNING_STATE=$(docker inspect -f '{{.State.Running}}' $container_id)
export CONTAINER_NAME=$(docker inspect -f '{{.Name}}' $container_id)
#export MAIL=<mail-id>

if [ $CONTAINER_RUNNING_STATE = "true" ]; 
then
  echo $CONTAINER_NAME : "Running";
  if [ $CONTAINER_RAM_UTILIZATION > $CONTAINER_RAM_UTIL_LIMIT ];
  then
    printf "Component Name: $CONTAINER_NAME' \n container is taking high RAM usage: $HOSTNAME \n ENV: $HOSTNAME \n Current RAM usage: $CONTAINER_RAM_UTILIZATION MiB"| mail -s "Component High RAM usage Alert on $HOSTNAME" $MAIL
    echo $CONTAINER_RAM_UTILIZATION;
  fi
  if [ CONTAINER_CPU_UTILIZATION > $CONTAINER_CPU_UTIL_LIMIT ];
  then
    printf "Component Name: $CONTAINER_NAME' \n container is taking high CPU usage: $HOSTNAME \n ENV: $HOSTNAME \n Current CPU usage: $CONTAINER_CPU_UTILIZATION CORES"| mail -s "Component High CPU usage Alert on $HOSTNAME" $MAIL
    echo $CONTAINER_CPU_UTILIZATION;
  fi
else 
  echo $CONTAINER_NAME : "Not Runnning";
  printf "Component Name: $CONTAINER_NAME' \n container is DOWN on host: $HOSTNAME \n ENV: $HOSTNAME"| mail -s "Component Down Alert" $MAIL
fi
done

export CURRENT_RAM_USAGE=$(free -m | awk 'NR == 2 {print $3}')
export TOTAL_RAM=$(free -m | awk 'NR == 2 {print $2}')
export USED_CPU=$(mpstat | awk 'NR == 4 {print $4}')

ans=$(( TOTAL_RAM - CURRENT_RAM_USAGE ))
usedram=$((ans*100 / TOTAL_RAM))
echo $usedram
if [ $usedram > $MACHINE_RAM_USAGE_LIMIT ];
then
  printf "High RAM utililzation has been obereved \n Current RAM utilization: $usedram Percent \n ENV: $HOSTNAME"| mail -s "$HOSTNAME High RAM Utilization Alert" $MAIL
fi

if [ $USED_CPU > $MACHINE_CPU_USAGE_LIMIT ];
then
  printf "High CPU utililzation has been obereved \n Current CPU utilization: $USED_CPU Percent \n ENV: $HOSTNAME"| mail -s "$HOSTNAME High CPU Utilization Alert" $MAIL
fi
