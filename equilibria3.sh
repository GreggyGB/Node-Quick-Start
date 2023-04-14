#! /bin/bash

install_checks () {
sudo apt install git
    install_node
}

install_node () {
  cd
  sudo apt install wget unzip
  sudo apt update
  sudo apt-get install  build-essential cmake pkg-config libboost-all-dev libssl-dev libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev libldns-dev libexpat1-dev doxygen graphviz libpgm-dev qttools5-dev-tools libhidapi-dev libusb-dev libprotobuf-dev protobuf-compiler
  git clone --recursive 'https://github.com/EquilibriaCC/Equilibria.git' equilibria && cd equilibria
  git submodule init && git submodule update
  git checkout v17.1.0
  make

  cd build/Linux/_HEAD_detached_at_v17.1.0_/release && mv bin ~/
  
  rm /etc/systemd/system/eqnode.service
  rm /etc/systemd/system/eqnode2.service
  rm /etc/systemd/system/eqnode3.service
  sudo cp ~/Equilibria/eqnode.service /etc/systemd/system/
  cp ~/bin/daemon ~/bin/xeq1
  cp ~/bin/daemon ~/bin/xeq2
  cp ~/bin/daemon ~/bin/xeq3
  sudo systemctl daemon-reload
  sudo systemctl enable eqnode.service
  sudo systemctl enable eqnode2.service
  sudo systemctl enable eqnode3.service
  sudo systemctl start eqnode.service
  sudo systemctl start eqnode2.service
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
  bash equilibria3.sh status
  systemctl status eqnode3.service
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
  rm -r ~/Equilibria/equilibria
  git clone --recursive 'https://github.com/EquilibriaCC/Equilibria.git' equilibria && cd equilibria
  git submodule init && git submodule update
  git checkout v17.1.0
  make
  sudo systemctl stop eqnode.service
  rm -r ~/bin
  cd build/Linux/_HEAD_detached_at_v17.1.0_/release && mv bin ~/
  cp ~/bin/daemon ~/bin/xeq1
  cp ~/bin/daemon ~/bin/xeq2
  cp ~/bin/daemon ~/bin/xeq3
  sudo systemctl enable eqnode.service
  sudo systemctl start eqnode.service
  sudo systemctl enable eqnode2.service
  sudo systemctl start eqnode2.service
  sudo systemctl enable eqnode3.service
  sudo systemctl start eqnode3.service
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
