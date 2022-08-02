#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0+
# Copyright (C) 2022 John Meneghini

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR = $DIR"

display_help() {
        echo
        echo " Usage: ${0##*/} [-h] <input_dir> <dev_name> <numjobs> <output_dir>"
        echo "  -h help "
	echo ""
        echo " Examples:"
        echo " # bench-fio --target /dev/nvme12n3 --type device --mode randread randwrite read write --output PowerstoreTCP --iodepth 1 8 16 32 64 --numjobs 12 --destructive "
	echo " # mkdir test1"
        echo " # ${0##*/} PowerstoreTCP nvme12n3 12 test1 "
	echo ""
}

if [ $# -lt 4 -o $# -gt 4 ]
then
	display_help
	exit
fi 

fio-plot -i $DIR/$1/$2/4k $DIR/$1/$2/8k $DIR/$1/$2/32k $DIR/$1/$2/64k -C -T "$1 RQ Size Compare (randread)" \
	-r randread --show-cpu --xlabel-parent 0 -d 32 -n $3 -o  $DIR/$4/$1_RQ_Compare_randread.png

fio-plot -i $DIR/$1/$2/4k $DIR/$1/$2/8k $DIR/$1/$2/32k $DIR/$1/$2/64k -C -T "$1 RQ Size Compare (randwite)" \
	-r randread --show-cpu --xlabel-parent 0 -d 32 -n $3 -o  $DIR/$4/$1_RQ_Compare_randwrite.png

fio-plot -i $DIR/$1/$2/4k $DIR/$1/$2/8k $DIR/$1/$2/32k $DIR/$1/$2/64k -C -T "$1 RQ Size Compare (read)" \
	-r read --show-cpu --xlabel-parent 0 -d 32 -n $3 -o  $DIR/$4/$1_RQ_Compare_read.png

fio-plot -i $DIR/$1/$2/4k $DIR/$1/$2/8k $DIR/$1/$2/32k $DIR/$1/$2/64k -C -T "$1 RQ Size Compare (write)" \
	-r write --show-cpu --xlabel-parent 0 -d 32 -n $3 -o  $DIR/$4/$1_RQ_Compare_write.png

