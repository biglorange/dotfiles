#!/bin/sh
# script to kill TIM
for pid in `pgrep TIM.exe`; do
	if [ -n ${pid} ]; then
		kill ${pid}
	fi
done
