#!/bin/bash
# PRIME GPU launcher via rofi

# Get GPU power state
gpu_status=$(cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status 2>/dev/null || echo "unknown")

# Build menu
options="Run application on NVIDIA\nGPU Status: $gpu_status\nnvidia-settings\nGPU Info (nvidia-smi)"

selected=$(echo -e "$options" | rofi -dmenu -p "NVIDIA RTX 5070 Ti" -theme-str 'window {width: 350px;}')

case "$selected" in
    "Run application on NVIDIA")
        app=$(rofi -dmenu -p "Application to run on NVIDIA")
        if [ -n "$app" ]; then
            notify-send "NVIDIA GPU" "Launching: $app"
            prime-run $app &
        fi
        ;;
    "nvidia-settings")
        prime-run nvidia-settings &
        ;;
    "GPU Info (nvidia-smi)")
        ghostty -e sh -c 'nvidia-smi; read -p "Press Enter to close..."' &
        ;;
esac
