#!/bin/bash
/usr/bin/Xvfb :99 -screen 0 1600x1200x16 &
/bin/sleep 5
cd /home/ubuntu/repo/
echo "Running continous-integration shell script"
./continuous-integration.sh
