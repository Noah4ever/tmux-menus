#!/usr/bin/env bash



if [[ "$TMUX_CONF" = "~/.tmux.conf" ]]; then
    plugins_dir="~/.tmux/plugins"
else
    plugins_dir="$(dirname "$TMUX_CONF")/plugins"
fi

echo "Defined plugins:"
echo

plugin_missing=false
mapfile -t plugins < <(grep "set -g @plugin" "$TMUX_CONF" | awk '{ print $4 }' | sed s/\"//g)
for plugin in "${plugins[@]}" ; do
    name="$(echo $plugin | cut -d/ -f2)"
    if [[ -d "$plugins_dir/$name" ]]; then
        echo "    $plugin"
    else
        echo "NOT INSTALLED: $plugin"
        plugin_missing=true
    fi
done

if $plugin_missing ; then
    if [[ -d "$plugins_dir/tpm" ]]; then
        echo
        echo "Install missing plugins with <prefix> I"
    fi
fi

echo
echo "Press <Escape> to clear this output"
