panic_handler() {
  print -u2 "Error while sourcing .env.zsh (line $LINENO)"
  print -u2 "Press Enter to continue..."
  read
}


sourceLocal() {
  [[ -f .env.zsh ]] && {
    setopt local_options ERR_RETURN
    trap "print -u2 \"Error while sourcing .env.zsh (line $LINENO)\"" ERR
    trap panic_handler EXIT
    source .env.zsh
  } always {
    trap - ERR
    trap - EXIT
  }
}
sourceLocal

chpwd() {
  sourceLocal
}
