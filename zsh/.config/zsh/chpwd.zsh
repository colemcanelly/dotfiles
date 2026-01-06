sourceLocal() {
  [[ -f .env.zsh ]] && source .env.zsh
}

sourceLocal

chpwd() {
  sourceLocal
}