# ============================================================
# Easy configuration
# ============================================================
DEFAULT_ENABLED=true          # start with blue light on?
TEMPERATURE=3000
# ============================================================

STATE=false

kill_state () {
    gammastep -x
    kill -9 $(pgrep gammastep) 2>/dev/null
    STATE=false
}

toggle_blue_light() {
    if STATE; then
        gammastep -O $TEMPERATURE -r &>/dev/null &
        STATE=true
    else
        kill_state
    fi
}

toggle_blue_light

# set_blue_light(enabled) {
#     if enabled; then
#         gammastep -O $TEMPERATURE -r &>/dev/null &
#         STATE=true
#     else
#         kill_state
#     fi
# }
#
# kill_state
# set_blue_light(DEFAULT_ENABLED)
