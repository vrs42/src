#!/bin/bash

#TODO: Allow changing these
PDP12_TOOLS_DIR=../PDP-12/PDP-12_Tools
TARGET_DISK_NAME=disk4.rk05
TARGET_DISK_SIDE=0

# Copy disk into 8tools
cp $PDP12_TOOLS_DIR/os8-disk-server/disks/$TARGET_DISK_NAME ./dhry.rk05

# Extract dhry disk
$PDP12_TOOLS_DIR/8tools/os8xplode ./dhry.rk05

# Copy dhrystone source
#cp ./dhry.rk05.$TARGET_DISK_SIDE/drystn.pa ./drystn.pa
cp ./dhry.rk05.$TARGET_DISK_SIDE/drysto.pa ./drystn_opt.pa
