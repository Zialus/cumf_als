#!/bin/bash

cat $1 | grep "solver run" | awk '{sum += $5} END {print sum}'
