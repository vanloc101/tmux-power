# =============================================================================
# Author: Chu Van Loc
# Email: donbb6823@gmail.com
# License: MIT License
# =============================================================================

# PRE-CONFIGS
# ==========

# $1: option
# $2: default value
tmux_get() {
    local value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}

# $1: option
# $2: value
tmux_set() {
    tmux set-option -gq "$1" "$2"
}


# OPTIONS
# ==========

right_arrow_icon=$(tmux_get '@tmux_power_right_arrow_icon' ' ')
left_arrow_icon=$(tmux_get '@tmux_power_left_arrow_icon' ' ')
upload_speed_icon=$(tmux_get '@tmux_power_upload_speed_icon' '')
download_speed_icon=$(tmux_get '@tmux_power_download_speed_icon' '')
session_icon="$(tmux_get '@tmux_power_session_icon' '')"
user_icon="$(tmux_get '@tmux_power_user_icon' '')"
time_icon="$(tmux_get '@tmux_power_time_icon' '')"
date_icon="$(tmux_get '@tmux_power_date_icon' '')"
show_upload_speed="$(tmux_get @tmux_power_show_upload_speed false)"
show_download_speed="$(tmux_get @tmux_power_show_download_speed false)"
show_web_reachable="$(tmux_get @tmux_power_show_web_reachable false)"
prefix_highlight_pos=$(tmux_get @tmux_power_prefix_highlight_pos)

# THEME COLOR
# ----------
TC=#CECECE

G01=#080808 #232
G02=#121212 #233
G03=#1c1c1c #234
G04=#262626 #235
G05=#303030 #236
G06=#3a3a3a #237
G07=#444444 #238
G08=#4e4e4e #239
G09=#585858 #240
G10=#626262 #241
G11=#6c6c6c #242
G12=#767676 #243

FG="$G12"
BG="$G04"

TBG=#1e1e1e

# STATUS OPTIONS
# ----------
tmux_set status-interval 1
tmux_set status on

# BASIC STATUS BAR COLORS
# ----------
tmux_set status-fg "$FG"
tmux_set status-bg "$BG"
tmux_set status-attr none

# TMUX-PREFIX-HIGHLIGHT
# ----------
tmux_set @prefix_highlight_fg "$BG"
tmux_set @prefix_highlight_bg "$FG"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$BG,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$BG]$left_arrow_icon#[bg=$TC]#[fg=$BG]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$BG]$right_arrow_icon"

#     
# LEFT SIDE OF STATUS BAR
# ----------
tmux_set status-left-bg "$G04"
tmux_set status-left-fg "G12"
tmux_set status-left-length 150
user=$(whoami)
LS="#[fg=$G04,bg=$TC,bold] $user_icon $user@#h #[fg=$TC,bg=$G06,nobold]$right_arrow_icon#[fg=$TC,bg=$G06] $session_icon #S "
if "$show_upload_speed"; then
    LS="$LS#[fg=$G06,bg=$G05]$right_arrow_icon#[fg=$TC,bg=$G05] $upload_speed_icon#{upload_speed} #[fg=$G05,bg=$BG]$right_arrow_icon"
else
    LS="$LS#[fg=$G06,bg=$BG]$right_arrow_icon"
fi
if [[ $prefix_highlight_pos == 'L' || $prefix_highlight_pos == 'LR' ]]; then
    LS="$LS#{prefix_highlight}"
fi
tmux_set status-left "$LS"

# RIGHT SIDE OF STATUS BAR
# ----------
tmux_set status-right-bg "$G04"
tmux_set status-right-fg "G12"
tmux_set status-right-length 150
RS="#[fg=$TC,bg=$G06] $time_icon %T#[fg=$TC,bg=$G06]$left_arrow_icon#[fg=$G04,bg=$TC] $date_icon %F "
if "$show_download_speed"; then
    RS="#[fg=$G05,bg=$BG]$left_arrow_icon#[fg=$TC,bg=$G05] $download_speed_icon#{download_speed} #[fg=$G06,bg=$G05]$left_arrow_icon$RS"
fi
if "$show_web_reachable"; then
    RS=" #{web_reachable_status} $RS"
fi
if [[ $prefix_highlight_pos == 'R' || $prefix_highlight_pos == 'LR' ]]; then
    RS="#{prefix_highlight}$RS"
fi
tmux_set status-right "$RS"

# WINDOW STATUS
# ----------
tmux_set window-status-format "#I:#W "
tmux_set window-status-current-format "#[fg=$BG,bg=$G06]$right_arrow_icon#[fg=$TC,bold]#I:#W #[fg=$G06,bg=$BG,nobold]$right_arrow_icon"

# WINDOW SEPARATOR
# ----------
tmux_set window-status-separator ""


# WINDOW STATUS ALIGNMENT
# ==========

# TMUX_SET STATUS-JUSTIFY CENTRE
# ----------
tmux_set status-justify left

# CURRENT WINDOW STATUS
# ----------
tmux_set window-status-current-style "fg=$TC,bg=$BG"

# PANE BORDER
# ----------
tmux_set pane-border-style "fg=$G07,bg=default"

# ACTIVE PANE BORDER
# ----------
tmux_set pane-active-border-style "fg=$TC,bg=$TBG"

# PANE NUMBER INDICATOR
# ----------
tmux_set display-panes-colour "$G08"
tmux_set display-panes-active-colour "$TC"

# CLOCK MODE
# ----------
tmux_set clock-mode-colour "$TC"
tmux_set clock-mode-style 24

# MESSAGE
# ----------
tmux_set message-style "fg=$G01,bg=$TC"

# COMMAND MESSAGE
# ----------
tmux_set message-command-style "fg=$G01,bg=$TC"

# COPY MODE HIGHLIGHT
# ----------
tmux_set mode-style "fg=$G01,bg=$TC"
