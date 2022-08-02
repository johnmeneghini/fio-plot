#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0+
# Copyright (C) 2022 John Meneghini

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR = $DIR"

rm -rf PowerstoreTCP*
rm -rf PowerstoreFC*
rm -rf PowerstoreiSCSI*
rm -rf output
mkdir output

bash $DIR/run_tests.sh PowerstoreTCP /dev/nvme12n4 12
bash $DIR/create_plots.sh PowerstoreTCP nvme12n4 12 output
bash $DIR/run_tests.sh PowerstoreTCP_1 /dev/nvme12n4 1
bash $DIR/create_plots.sh PowerstoreTCP_1 nvme12n4 1 output

bash $DIR/run_tests.sh PowerstoreFC /dev/nvme12n2 12
bash $DIR/create_plots.sh PowerstoreFC nvme12n2 12 output
bash $DIR/run_tests.sh PowerstoreFC_1 /dev/nvme12n2 1
bash $DIR/create_plots.sh PowerstoreFC_1 nvme12n2 1 output

bash $DIR/run_tests.sh PowerstoreiSCSI /dev/mapper/mpatha 12
bash $DIR/create_plots.sh PowerstoreiSCSI mpatha 12 output
bash $DIR/run_tests.sh PowerstoreiSCSI_1 /dev/mapper/mpatha 1
bash $DIR/create_plots.sh PowerstoreiSCSI_1 mpatha 1 output

