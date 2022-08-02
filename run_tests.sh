#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0+
# Copyright (C) 2022 John Meneghini

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR = $DIR"

display_help() {
        echo
        echo " Usage: ${0##*/} [-h] <output_dir> <dev_name> <numjobs>"
        echo "  -h help "
	echo ""
        echo " Examples:"
        echo " # ${0##*/} PowerstoreTCP /dev/nvme12n3 12 "
	echo ""
}

if [ $# -lt 3 -o $# -gt 3 ]
then
	display_help
	exit
fi 

bench-fio --target $2 --type device --mode randread randwrite read write --engine libaio --block-size 4k 8k 32k 64k \
	--output $1 --iodepth 1 8 16 32 64 --numjobs $3 --destructive

