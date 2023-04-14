#! /bin/bash

install_checks () {
sudo apt install git
    install_node
}

install_node () {
  cd
  rm /etc/systemd/system/eqnode2.service
  sudo cp ~/Equilibria/eqnode2.service /etc/systemd/system/
  rm ~/bin/xeq2
  cp ~/bin/daemon ~/bin/xeq2
  sudo systemctl daemon-reload
  sudo systemctl enable eqnode2.service
  sudo systemctl start eqnode2.service
}

prepare_sn () {
  ~/bin/xeq2 --rpc-bind-port 9241 prepare_sn
}

start () {
  systemctl start eqnode2.service
  echo Service node started to check it works use bash equilibria.sh log
}

status () {
  systemctl status eqnode2.service
}

stop_all_nodes () {
  echo Stopping XEQ2 node
  sudo systemctl stop eqnode2.service
}

start_all () {
  echo Starting XEQ nodes 0-3.
  sudo systemctl start eqnode.service
  sudo systemctl start eqnode2.service
  sudo systemctl start eqnode3.service
}

log () {
  sudo journalctl -u eqnode2.service -af
}

update () {
  git pull
}

print_sn_key () {
  echo xeq1 key
  ~/bin/xeq1 --rpc-bind-port 9231 print_sn_key
  echo xeq2 key
  ~/bin/xeq2 --rpc-bind-port 9241 print_sn_key
  echo xeq3 key
  ~/bin/xeq3 --rpc-bind-port 9251 print_sn_key
}

fork_update () {
  echo This is only available from equilibria.sh
}

case "$1" in
  install ) install_checks ;;
  prepare_sn ) prepare_sn ;;
  start ) start ;;
  stop ) stop_all_nodes ;;
  status ) status ;;
  log ) log ;;
  update ) update ;;
  fork_update ) fork_update ;;
  status_all ) status_all_nodes ;;
  start_all ) start_all ;;
  print_sn_key ) print_sn_key ;;
esac
