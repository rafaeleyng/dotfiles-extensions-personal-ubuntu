#!/bin/zsh

# arcano


########################################
# pactl
########################################
# Logitech webcam
SOURCE_RAW="alsa_input.usb-046d_HD_Pro_Webcam_C920_AF6A747F-02.iec958-stereo"
# Display Asus
SINK_RAW="alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"

# Arcano Black
SOURCE_PRO="alsa_input.usb-ARCANO_AM-BLACK-1_ARCANO_AM-BLACK-1-00.mono-fallback"
# Galaxy Buds+
SINK_PRO="bluez_sink.08_BF_A0_D7_01_35.a2dp_sink"

alias s='pactl'

function configure_sound () {
  SOURCE=$1
  SINK=$2

  s set-default-source "$SOURCE"
  s set-default-sink "$SINK"
}

alias s1="configure_sound \"$SOURCE_RAW\" \"$SINK_RAW\"" # raw
alias s4="configure_sound \"$SOURCE_PRO\" \"$SINK_PRO\"" # pro
