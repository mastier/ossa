#!/bin/bash
#
#OSSA_TOOL_URL=https://github.com/mastier/ossa.git
export OSSA_GENERATOR_UBUNTU_VERSION="24.04"
RESULTS_DIR="$(mktemp -d)"

export RESULTS_DIR

launch_generator_vm() {
  echo "=== ossa-generator: Launched"
  lxc launch --vm -c limits.cpu=4 -c limits.memory=4GiB "ubuntu:${OSSA_GENERATOR_UBUNTU_VERSION}" "ossa-generator"
}

launch_collector_vm() {
  version="$1"
  echo "=== ossa-$version: Launched"
  lxc launch --vm "ubuntu:$version" "ossa-$(echo "$version"| tr -d '.' )" 

}
# required for parallel
export -f launch_collector_vm 

launch_collector_vms() {
  parallel launch_collector_vm ::: 20.04 22.04 24.04
}

wait_ready() {
  vmname="$1"
  echo "=== $vmname: Waiting for readiness"
  while true; do
    lxc exec "$vmname" systemctl is-system-running >/dev/null 2>&1 && break
    sleep 2
  done
  echo "adding shared disk"
  lxc config device add "$vmname" ossa-shared disk source="${RESULTS_DIR}" path=/mnt/
  echo "=== $vmname: Ready"
}
export -f wait_ready

wait_ready_all() {
  parallel wait_ready ::: ossa-generator ossa-2004 ossa-2204 ossa-2404
}


collect_vm() {
  version="$1"
  lxc exec "ossa-$version" -- sudo -u ubuntu sh -c '
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -P "" >/dev/null
  ssh-keygen -y -f ~/.ssh/id_ed25519 > ~/.ssh/authorized_keys 
  cd ~ ; git clone https://github.com/mastier/ossa.git || echo
  cd ossa 
  ./collector.sh ubuntu@$(hostname)
  mv /tmp/ossa-collector-data.*.tgz /mnt'
}
export -f collect_vm

run_generate() {
  lxc exec "ossa-generator" -- sudo -u ubuntu sh -c '
  sudo apt update -q
  sudo apt install -yq openscap-daemon >/dev/null
  sudo apt install -yq bzip2 >/dev/null
  cd ~ ; git clone https://github.com/mastier/ossa.git || echo
  cd ossa 
  for data in /mnt/ossa-collector-data.*.tgz ; do ./generator.sh $data ; done
  cp -a /opt/ossa /mnt/'
}

launch_generator_vm
launch_collector_vms
wait_ready_all

parallel collect_vm ::: 2004 2204 2404
run_generate

echo "=== Clean up VMs"
#lxc delete --force ossa-generator ossa-2004 ossa-2204 ossa-2404
echo "=== Finished ==="
echo "You can find the collected data and results in the folder $RESULTS_DIR"
