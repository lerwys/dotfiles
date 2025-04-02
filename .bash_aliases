function ssh_alias() {
  ssh "$@";
  setterm --default --clear rest;
}

alias ssh=ssh_alias
