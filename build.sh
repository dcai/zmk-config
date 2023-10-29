#!/bin/sh
CMD_NAME=$(basename "$0")

if [ $# -ne 1 ]; then
    echo "Usage: ${CMD_NAME} [keyboard_name]"
    exit 1
fi

keymap=${1}.keymap
yaml=${1}-keymap.yaml
svg=${1}-keymap.svg

print_and_run_cmd() {
    cmd=$1
    echo "=> $cmd$"
    eval "$cmd"
}

cmd="keymap parse -z config/${keymap} >./assets/${yaml}"
print_and_run_cmd "$cmd"
cmd="keymap draw ./assets/${yaml} >./assets/${svg}"
print_and_run_cmd "$cmd"
