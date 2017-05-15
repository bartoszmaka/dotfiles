# Indicator of pressing TMUX prefix, copy and insert modes.

prefix_pressed_text="Prefix"
insert_mode_text="Insert"
copy_mode_text=" Copy "
normal_mode_text="Normal"
separator=""

prefix_mode_fg="#ff0000"
normal_mode_fg="#000000"
copy_mode_fg="#ff0000"
bg="#e5c07b"

run_segment() {
        prefix_indicator="#[bg=${bg}]#{?client_prefix,#[fg=${prefix_mode_fg}]${prefix_pressed_text},#[fg=${normal_mode_fg}]${normal_mode_text}}"
        normal_or_copy_indicator="#[bg=${bg}]#{?pane_in_mode,#[fg=${copy_mode_fg}]${copy_mode_text},#[fg=${normal_mode_fg}]${insert_mode_text}}";
        echo $prefix_indicator "#[fg=${normal_mode_fg}]${separator}" $normal_or_copy_indicator
        return 0
}
