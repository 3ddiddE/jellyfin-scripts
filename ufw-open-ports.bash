#!/bin/bash
set -e

readarray -t PORTS < ports
readarray -t PRIVATE_SUBNETS < subnets

for subnet in "${PRIVATE_SUBNETS[@]}"; do
  for port_proto_str in "${PORTS[@]}"; do
    if [[ "$port_proto_str" =~ ^([0-9]+)/(tcp|udp) ]]; then
      port=${BASH_REMATCH[1]}
      proto=${BASH_REMATCH[2]}
      ufw allow from "${subnet}" to any port "${port}" proto "${proto}"
    else
      exit 1
    fi
  done
done
