#!/bin/bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")/"

# sudo modprobe --remove v4l2loopback

if lsmod | grep -w v4l2loopback >/dev/null 2>/dev/null; then
    echo "[INFO] Module found"
else
    # run second device for background remover
    sudo modprobe v4l2loopback devices=2 exclusive_caps=1 video_nr=2 card_label="fake-cam"
    echo "[INFO] Module loaded"
fi

./run-videochat.sh --use-wifi 192.168.22.100 --video
