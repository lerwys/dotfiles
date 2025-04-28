function ssh_alias() {
  ssh "$@";
  setterm --default --clear rest;
}
