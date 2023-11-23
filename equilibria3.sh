#! /bin/bash

install_checks () {
  install_node
}

install_node () {
  rm /etc/systemd/system/eqnode3.service
  sudo cp ~/Equilibria/eqnode3.service /etc/systemd/system/
  rm -r /~/.equilibria3
  mkdir /~/.equilibria3
  echo Cloning blockchain - please give me few minutes...
  cp -r ~/.equilibria/lmdb /~/.equilibria3/
  rm ~/bin/xeq3
  cp ~/bin/daemon ~/bin/xeq3
  sudo systemctl daemon-reload
  sudo systemctl enable eqnode3.service
  sudo systemctl start eqnode3.service
}

prepare_sn () {
  ~/bin/xeq3 --rpc-bind-port 9251 prepare_sn
}

start () {
  systemctl start eqnode3.service
  echo Service node started to check it works use bash equilibria3.sh log
}

status () {
  ~/bin/xeq3 --rpc-bind-port 9251 status
}

stop_all_nodes () {
  echo Stopping XEQ nodes
  sudo systemctl stop eqnode.service
  sudo systemctl stop eqnode2.service
  sudo systemctl stop eqnode3.service
}

start_all () {
  echo Starting XEQ nodes 0-3.
  sudo systemctl start eqnode.service
  sudo systemctl start eqnode2.service
  sudo systemctl start eqnode3.service
}

log () {
  sudo journalctl -u eqnode3.service -af
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
