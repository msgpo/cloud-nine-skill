#!/bin/bash
# The requirements.sh is an advanced mechanism an should rarely be needed.
# Be aware that it won't run with root permissions and 'sudo' won't work
# in most cases.

#detect distribution using lsb_release (may be replaced parsing /etc/*release)
dist=$(lsb_release -ds)

#setting dependencies and package manager in relation to the distribution

if $(hash pkcon 2>/dev/null); then
    pm="pkcon"
else
    priv="sudo"
    if [ "$dist"  == "\"Arch Linux\""  ]; then
        pm="pacman -S"
        dependencies=( odejs tmux )
    elif [[ "$dist" =~  "Ubuntu" ]] || [[ "$dist" =~ "Debian" ]] ||[[ "$dist" =~ "Raspbian" ]]; then
        pm="apt install"
        dependencies=( nodejs tmux)
    elif [[ "$dist" =~ "SUSE" ]]; then 
        pm="zypper install"
        dependencies=( nodejs tmux )
    fi
fi


# installing dependencies
if [ ! -z "$pm" ]; then
    for dep in "${dependencies[@]}"
    do
        $priv $pm $dep
    done
fi


git clone https://github.com/c9/core.git c9
c9/scripts/install-sdk.sk
mkdir workspaces
ln -s /opt/mycroft/skills workspaces/mycroft-skills

