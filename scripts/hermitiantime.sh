#!/bin/bash

cat $1 | grep "update" | grep "kernel run" | awk '{sum += $5} END {print sum}'
