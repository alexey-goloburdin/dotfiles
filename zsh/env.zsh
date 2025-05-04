export PATH="/home/alexeygoloburdin/.local/bin:$PATH"
export EDITOR=vim
# for wl-copy working on WSL (for pass -c and others)
export XDG_RUNTIME_DIR=/run/user/$(id -u)
ln -s /mnt/wslg/runtime-dir/wayland-0 $XDG_RUNTIME_DIR/wayland-0 2>/dev/null
ln -s /mnt/wslg/runtime-dir/wayland-0.lock $XDG_RUNTIME_DIR/wayland-0.lock 2>/dev/null

# disable green bg for some directories
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

