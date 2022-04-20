#!/bin/sh
#
#   Copyright (c) 2022: Jacob.Lundqvist@gmail.com
#   License: MIT
#
#   Part of https://github.com/jaclu/tmux-menus
#
#   Version: 1.2.8 2022-04-20
#
#   Handling pane
#
#   Types of menu item lines.
#
#   1) An item leading to an action
#          "Description" "In-menu key" "Action taken when it is triggered"
#
#   2) Just a line of text
#      You must supply two empty strings, in order for the
#      menu logic to interpret it as a full menu line item.
#          "Some text to display" "" ""
#
#   3) Separator line
#      This is a proper graphical separator line, without any label.
#          ""
#
#   4) Labeled separator line
#      Not perfect, since you will have at least one space on each side of
#      the labeled separator line, but using something like this and carefully
#      increase the dashes until you are just below forcing the menu to just
#      grow wider, seems to be as close as it gets.
#          "#[align=centre]-----  Other stuff  -----" "" ""
#
#
#   All but the last line in the menu, needs to end with a continuation \
#   White space after this \ will cause the menu to fail!
#   For any field containing no spaces, quotes are optional.
#

# shellcheck disable=SC1007
CURRENT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SCRIPT_DIR="$(dirname "$CURRENT_DIR")/scripts"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/utils.sh"


# shellcheck disable=SC2154
tmux display-menu  \
     -T "#[align=centre] Handling Pane "  \
     -x "$menu_location_x" -y "$menu_location_y"  \
     \
     "Back to Main menu"  Left  "run-shell $CURRENT_DIR/main.sh"  \
     "" \
     "    Move pane  -->"     M  "run-shell \"$CURRENT_DIR/pane_move.sh\""    \
     "    Resize pane  -->"   R  "run-shell \"$CURRENT_DIR/pane_resize.sh\""  \
     "    Paste buffers -->"  B  "run-shell \"$CURRENT_DIR/pane_buffers.sh\"" \
     "" \
     "    Set Title"             t  "command-prompt -I \"#T\"  -p \"Title: \"  \"select-pane -T '%%'\""  \
     "<P> Zoom pane toggle"      z  "resize-pane -Z" \
     "<P> Display pane numbers"  q  "display-panes ; run-shell \"$CURRENT_DIR/panes.sh\""    \
     "<P> Copy mode (~scrollback)" \[ "copy-mode" \
     "    Display pane size"     s  "display-message \"Pane: #P size: #{pane_width}x#{pane_height}\"" \
     "" \
     "    #{?pane_synchronized,#[bold]Disable[#defaults],Activate} synchronized panes"  y  "set -w synchronize-panes"  \
     "    Save pane history to file"   h  "command-prompt -p 'Save current-pane history to filename:' -I '~/tmux.history' 'capture-pane -S - -E - ; save-buffer %1 ; delete-buffer'" \
     "" \
     "    Respawn current pane"        r  "confirm-before -p \"respawn-pane #P? (y/n)\" \"respawn-pane -k\"" \
     "<P> Kill current pane"           x  "confirm-before -p \"kill-pane #P? (y/n)\" kill-pane"      \
     "    Kill all other panes"        o  "confirm-before -p \"Are you sure you want to kill all other panes? (y/n)\" \"kill-pane -a\""      \
     "" \
     "Help  -->"  H  "run-shell \"$CURRENT_DIR/help.sh $CURRENT_DIR/panes.sh\""
