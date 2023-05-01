#!/bin/zsh

########################################
# wezterm
########################################
alias wezterm='flatpak run org.wezfurlong.wezterm'

# https://github.com/wez/wezterm/issues/207
__vte_urlencode() (
  # This is important to make sure string manipulation is handled
  # byte-by-byte.
  LC_ALL=C
  str="$1"
  while [ -n "$str" ]; do
    safe="${str%%[!a-zA-Z0-9/:_\.\-\!\'\(\)~]*}"
    printf "%s" "$safe"
    str="${str#"$safe"}"
    if [ -n "$str" ]; then
      printf "%%%02X" "'$str"
      str="${str#?}"
    fi
  done
)

__vte_osc7 () {
  printf "\033]7;file://%s%s\007" "${HOSTNAME:-}" "$(__vte_urlencode "${PWD}")"
}

__vte_prompt_command() {
  local command=$(HISTTIMEFORMAT= history 1 | sed 's/^ *[0-9]\+ *//')
  command="${command//;/ }"
  local pwd='~'
  [ "$PWD" != "$HOME" ] && pwd=${PWD/#$HOME\//\~\/}
  printf "\033]777;notify;Command completed;%s\007\033]0;%s@%s:%s\007%s" "${command}" "${USER}" "${HOSTNAME%%.*}" "${pwd}" "$(__vte_osc7)"
}

case "$TERM" in
  xterm*|vte*)
    [ -n "$BASH_VERSION" ] && PROMPT_COMMAND="__vte_prompt_command"
    [ -n "$ZSH_VERSION"  ] && precmd_functions+=(__vte_osc7)
    ;;
esac

########################################
# sound
########################################
# Logitech webcam
SOURCE_RAW="alsa_input.usb-046d_HD_Pro_Webcam_C920_AF6A747F-02.analog-stereo"

# Line out
SINK_RAW="alsa_output.pci-0000_00_1f.3.analog-stereo"

# # Display Asus
# SINK_RAW="alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"

# Arcano Black
SOURCE_PRO="alsa_input.usb-ARCANO_AM-BLACK-1_ARCANO_AM-BLACK-1-00.mono-fallback"

# Galaxy Buds+
SINK_PRO="bluez_sink.08_BF_A0_D7_01_35.a2dp_sink"

alias s='pactl'

function configure_sound () {
  SOURCE=$1
  SINK=$2

  echo "Setting source: $SOURCE"
  s set-default-source "$SOURCE"
  echo "Setting sink  : $SINK"
  s set-default-sink "$SINK"
}

alias s1="configure_sound \"$SOURCE_RAW\" \"$SINK_RAW\"" # raw
alias s4="configure_sound \"$SOURCE_PRO\" \"$SINK_PRO\"" # pro


########################################
# clipboard
########################################
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
