#!/bin/bash

sleep 3
tmux new-session -d -s tunnelmux
sleep 1
tmux send-keys '/home/tunnel/keep-mux-tunnel.sh' C-m
