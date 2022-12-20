#!/bin/sh
#
#   Copyright (c) 2022: Jacob.Lundqvist@gmail.com
#   License: MIT
#
#   Part of https://github.com/jaclu/tmux-menus
#
#   Displays public IP
#

echo  # Extra LF to avoid cursor placed over text
echo "Public IP: $(curl ifconfig.me)"
echo
echo "Press Escape to exit this output"
