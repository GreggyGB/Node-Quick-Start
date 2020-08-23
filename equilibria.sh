#! /bin/bash

install_checks () {
sudo apt install git
#if [ "$(ls -A ~/bin)" ]; then
#  read -p "Folder '~/bin' from another node already exists. Do you want us to remove it? (Y/N)"
#  if [[ $REPLY =~ ^[Yy]$ ]]
#  then
#    rm -r ~\bin
#    echo "Folder deleted. Proceeding with installation."
    install_node
#  else
#    echo "User aborted installation."
#    exit 1
#  fi
#fi
}
install_node () {
  sudo apt install wget unzip
  sudo apt update
  sudo apt-get install  build-essential cmake pkg-config libboost-all-dev libssl-dev libzmq3-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline6-dev libldns-dev libexpat1-dev doxygen graphviz libpgm-dev qttools5-dev-tools libhidapi-dev libusb-dev libprotobuf-dev protobuf-compiler
  git clone --recursive 'https://github.com/EquilibriaCC/Equilibria.git' equilibria && cd equilibria
  git submodule init && git submodule update
  git checkout v6.0.3
  make

  cd build/Linux/_HEAD_detached_at_v6.0.3_/release && mv bin ~/
  
  rm /etc/systemd/system/eqnode.service
  cp ~/Equilibria/eqnode.service /etc/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl enable eqnode.service
}

prepare_sn () {
  ~/bin/daemon prepare_sn
}

start () {
  systemctl start eqnode.service
  echo Service node started to check it works use bash equilibria.sh log
}

status () {
  systemctl status eqnode.service
}

stop_all_nodes () {
  echo Stopping XEQ node
  sudo systemctl stop eqnode.service
}

log () {
  sudo journalctl -u eqnode.service -af
}

update () {
  git pull
}
case "$1" in
  install ) install_checks ;;
  prepare_sn ) prepare_sn ;;
  start ) start ;;
  stop ) stop_all_nodes ;;
  status ) status ;;
  log ) log ;;
  update ) update ;;
esac
