#!/bin/bash
tcpdump -ddd $4 | sed -r 's/(^(177|80|72|64)( [0-9]{1,2}){2} )([0-9]{1,10})/echo "\1$((\4-14))"/ge' | sed '2,7d' | sed '$d' | sed -re '$s/.+/6 0 0 1\n6 0 0 0/g' | sed -re '1s/(^[0-9]+)/echo "$((\1-6))"/ge' | tr "\n" "," | sed -r "s/^/sudo iptables -A $1 -p $2 -m bpf --bytecode \"/g" | sed -r "s/$/\" -j LOG --log-prefix 'iptables-$3'/g"
echo ""
