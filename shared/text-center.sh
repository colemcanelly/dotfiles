
function center() {
    local pad_char="$1"
    local s="$3"
    local str_no_color=$(echo -e "$s" | sed 's/\x1b\[[0-9;]*[mGKH]//g')
    local width="${2:-80}"
    local str_len=${#str_no_color}

    if (( width <= str_len )); then
        printf '%s\n' "$s"
        return
    fi

    local pad_total=$((width - str_len))
    local pad_left=$((pad_total / 2))
    local pad_right=$((pad_total - pad_left))

    printf '%*s' "$pad_left" '' | tr ' ' "$pad_char"
    printf '%b' "$s"
    printf '%*s\n' "$pad_right" '' | tr ' ' "$pad_char"
}