#!/bin/zsh

# arcano


########################################
# pactl
########################################
# Logitech webcam
S_INP_RAW="alsa_input.usb-046d_HD_Pro_Webcam_C920_AF6A747F-02.iec958-stereo"
# Display Asus
S_OUT_RAW="alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"

# Arcano Black
S_INP_PRO="alsa_input.usb-ARCANO_AM-BLACK-1_ARCANO_AM-BLACK-1-00.mono-fallback"
# Galaxy Buds+
S_OUT_PRO="bluez_sink.08_BF_A0_D7_01_35.a2dp_sink"

alias s='pactl'

function configure_sound () {
  SOUND_INP=$1
  SOUND_OUT=$2

  s set-default-source "$SOUND_INP"
  s set-default-sink "$SOUND_OUT"
}

alias s1="configure_sound \"$S_INP_RAW\" \"$S_OUT_RAW\""              # raw
alias s4="configure_sound \"$S_INP_PRO\" \"$S_OUT_PRO\""              # pro
