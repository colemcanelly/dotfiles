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

# Overload to use sshpass with certain ssh targets
function ssh () { 
    case $1 in 
        465ctf) sshpass -f ~/csce465/ctfinfo/passwd.txt /usr/bin/ssh 465ctf;;
        465socks) echo "14741inictfsocks465!"; /usr/bin/ssh -f 465socks;;
        *) /usr/bin/ssh "$@";;
    esac
}