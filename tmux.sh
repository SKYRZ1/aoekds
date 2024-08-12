#!/bin/bash

# Install tmux jika belum terinstall
if ! command -v tmux &> /dev/null; then
    apt update -y
    apt upgrade -y
    apt install gnupg -y
    apt install tmux -y
fi

# Path ke skrip yang akan dijalankan
SCRIPT_PATH="./install.sh"

# Cek jika file install1.sh sudah ada, jika belum maka download
if [ ! -f "$SCRIPT_PATH" ]; then
    wget https://raw.githubusercontent.com/SKYRZ1/aoekds/main/install.sh -O "$SCRIPT_PATH" && chmod +x "$SCRIPT_PATH"
fi

# Nama sesi tmux dan path ke skrip/program
SESSION_NAME="ric"

# Cek jika sesi tmux sudah ada
if ! tmux has-session -t $SESSION_NAME 2>/dev/null; then
    # Membuat sesi tmux baru
    tmux new -s $SESSION_NAME
fi

# Kirim perintah untuk menjalankan skrip ke sesi tmux
tmux send-keys -t $SESSION_NAME "bash $SCRIPT_PATH" C-m

# Masuk ke sesi tmux
tmux attach -t $SESSION_NAME
