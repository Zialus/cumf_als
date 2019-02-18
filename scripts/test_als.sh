#!/bin/bash

mkdir $1 # should be a directory

./exec/cumf_als 480189 17770 10 99072112 1408395 0.048 1 1 ../../DATASETS/netflix/ > $1/als.10
./exec/cumf_als 480189 17770 20 99072112 1408395 0.048 1 1 ../../DATASETS/netflix/ > $1/als.20
./exec/cumf_als 480189 17770 30 99072112 1408395 0.048 1 1 ../../DATASETS/netflix/ > $1/als.30
./exec/cumf_als 480189 17770 40 99072112 1408395 0.048 1 1 ../../DATASETS/netflix/ > $1/als.40
./exec/cumf_als 480189 17770 50 99072112 1408395 0.048 1 1 ../../DATASETS/netflix/ > $1/als.50
./exec/cumf_als 480189 17770 60 99072112 1408395 0.048 1 1 ../../DATASETS/netflix/ > $1/als.60

./exec/cumf_als 480189 17770 70 99072112 1408395 0.048 2 1 ../../DATASETS/netflix/ > $1/als.70
./exec/cumf_als 480189 17770 80 99072112 1408395 0.048 2 1 ../../DATASETS/netflix/ > $1/als.80
./exec/cumf_als 480189 17770 90 99072112 1408395 0.048 2 1 ../../DATASETS/netflix/ > $1/als.90

./exec/cumf_als 480189 17770 100 99072112 1408395 0.048 3 1 ../../DATASETS/netflix/ > $1/als.100
./exec/cumf_als 480189 17770 110 99072112 1408395 0.048 3 1 ../../DATASETS/netflix/ > $1/als.110

./exec/cumf_als 480189 17770 120 99072112 1408395 0.048 4 1 ../../DATASETS/netflix/ > $1/als.120
./exec/cumf_als 480189 17770 130 99072112 1408395 0.048 4 1 ../../DATASETS/netflix/ > $1/als.130

./exec/cumf_als 480189 17770 140 99072112 1408395 0.048 5 1 ../../DATASETS/netflix/ > $1/als.140

./exec/cumf_als 480189 17770 150 99072112 1408395 0.048 6 1 ../../DATASETS/netflix/ > $1/als.150
./exec/cumf_als 480189 17770 160 99072112 1408395 0.048 6 1 ../../DATASETS/netflix/ > $1/als.160

./exec/cumf_als 480189 17770 170 99072112 1408395 0.048 7 1 ../../DATASETS/netflix/ > $1/als.170

./exec/cumf_als 480189 17770 180 99072112 1408395 0.048 8 1 ../../DATASETS/netflix/ > $1/als.180

./exec/cumf_als 480189 17770 190 99072112 1408395 0.048 9 1 ../../DATASETS/netflix/ > $1/als.190
./exec/cumf_als 480189 17770 200 99072112 1408395 0.048 9 1 ../../DATASETS/netflix/ > $1/als.200
