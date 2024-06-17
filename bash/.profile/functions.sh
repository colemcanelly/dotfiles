function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
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
    hex=$1
    if [[ $hex == "#"* ]]; then
        hex=$(echo $1 | awk '{print substr($0,2)}')
    fi
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
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
