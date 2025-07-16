function extract () {
    if [ -f "$1" ] ; then
        local target_dir="${2:-.}" # Default to the current directory if no second argument is provided
        echo "Extracting '$1' to '$target_dir'"
        mkdir -p "$target_dir"
        case "$1" in
            *.tar.bz2|*.tbz2) tar -xvjf "$1" -C "$target_dir" ;;
            *.tar.xz)         tar -xvJf "$1" -C "$target_dir" ;;
            *.tar.gz|*.tgz)   tar -xvzf "$1" -C "$target_dir" ;;
            *.bz2)            bunzip2 -c "$1" > "$target_dir/${1%.bz2}" ;;
            *.rar)            rar -x "$1" "$target_dir" ;;
            *.gz)             gunzip -c "$1" > "$target_dir/${1%.gz}" ;;
            *.tar)            tar -xvf "$1" -C "$target_dir" ;;
            *.zip)            unzip "$1" -d "$target_dir" ;;
            *.Z)              uncompress -c "$1" > "$target_dir/${1%.Z}" ;;
            *.xz)             xz -d "$1" ;;
            *.7z)             7z -x "$1" ;;
            *.a)              ar -x "$1" ;;
            *)                echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# fromhex A52A2A
# fromhex "#A52A2A"
# BLUE_VIOLET=$(fromhex "#8A2BE2")
# http://unix.stackexchange.com/a/269085/67282
function fromhex() {
    if [[ -z "$1" ]]; then
        echo "Usage: fromhex <hex_color>"
        return 1
    fi
    local hex="${1#'#'}"
    local r=$(printf '0x%0.2s' "$hex")
    local g=$(printf '0x%0.2s' ${hex#??})
    local b=$(printf '0x%0.2s' ${hex#????})
    echo -e `printf "%03d" "$(((r<75?0:(r-35)/40)*6*6+(g<75?0:(g-35)/40)*6+(b<75?0:(b-35)/40)+16))"`
}

# Overload to use sshpass with certain ssh targets
function ssh () { 
    case $1 in 
        465ctf) sshpass -f ~/csce465/ctfinfo/passwd.txt /usr/bin/ssh 465ctf;;
        465socks) echo "14741inictfsocks465!"; /usr/bin/ssh -f 465socks;;
        *) /usr/bin/ssh "$@";;
    esac
}



# convert first measurement to the second units
function convert() {
    units -to %.0f $1 $2
}

function diff-test-coverage () {
    local changed_files="git diff origin/develop --name-only";
    local test_files=($(eval $changed_files | rg '/src/.*\.spec.(ts|tsx|js|jsx)$'));
    local src_files=($(comm -23 <(eval \$changed_files | rg '/src/.*\.(ts|tsx|js|jsx)$') <(printf "%s\n" ${test_files[@]}| sort)));

    local red="\033[0;31m";
    local green="\033[0;92m";
    local bold="\033[1m";
    local reset="\033[0m";


    for src in "${src_files[@]}"; do
        local pretty_src="$(echo ${src} | sed -E 's|.*/([^/]+)/src/|@\1/src/|')";
        local ext="${src##*.}";
        local test_file="${src%.*}.spec.${ext}";
        if [[ " ${test_files[*]} " =~ " ${test_file} " ]]; then
            printf "${green}${bold}${pretty_src}${reset} -> ${green}$(basename $test_file)"
        else
            printf "${red}${pretty_src}"
        fi

        printf "${reset}\n"
    done
}