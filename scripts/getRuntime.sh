#!/bin/bash

cat $1 | grep "update" | grep "run" | grep "gridSize" | grep -v kernel | awk '{sum += $4} END {print sum}'
