#!/bin/bash

#$1 should be a directory
mkdir $1

../exec/cumf_als 17770 480189 10 99072112 1408395 0.048 1 1 ../../data/netflix/ > $1/als.10
../exec/cumf_als 17770 480189 20 99072112 1408395 0.048 1 1 ../../data/netflix/ > $1/als.20
../exec/cumf_als 17770 480189 30 99072112 1408395 0.048 1 1 ../../data/netflix/ > $1/als.30

../exec/cumf_als 17770 480189 40 99072112 1408395 0.048 1 2 ../../data/netflix/ > $1/als.40
../exec/cumf_als 17770 480189 50 99072112 1408395 0.048 1 2 ../../data/netflix/ > $1/als.50
../exec/cumf_als 17770 480189 60 99072112 1408395 0.048 1 2 ../../data/netflix/ > $1/als.60

../exec/cumf_als 17770 480189 70 99072112 1408395 0.048 1 3 ../../data/netflix/ > $1/als.70
../exec/cumf_als 17770 480189 80 99072112 1408395 0.048 1 3 ../../data/netflix/ > $1/als.80
../exec/cumf_als 17770 480189 90 99072112 1408395 0.048 1 3 ../../data/netflix/ > $1/als.90
../exec/cumf_als 17770 480189 100 99072112 1408395 0.048 1 3 ../../data/netflix/ > $1/als.100

../exec/cumf_als 17770 480189 110 99072112 1408395 0.048 1 4 ../../data/netflix/ > $1/als.110
../exec/cumf_als 17770 480189 120 99072112 1408395 0.048 1 4 ../../data/netflix/ > $1/als.120

../exec/cumf_als 17770 480189 130 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.130
../exec/cumf_als 17770 480189 140 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.140
../exec/cumf_als 17770 480189 150 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.150
../exec/cumf_als 17770 480189 160 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.160
../exec/cumf_als 17770 480189 170 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.170
../exec/cumf_als 17770 480189 180 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.180
../exec/cumf_als 17770 480189 190 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.190
../exec/cumf_als 17770 480189 200 99072112 1408395 0.048 1 10 ../../data/netflix/ > $1/als.200
