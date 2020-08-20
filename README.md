# bpf-bytecode-helper
converts tcpdump's output of -ddd to a bytecode iptables can understand and act on

usage

./tcpdump_conv.sh "iptables chain" "transport protocol" "log-tag-here" "bpf filter here"
  
 example for packet starting with "SSH-"
 
 ./tcpdump_conv.sh "INPUT" "tcp" "ssh-detected" "tcp[(4*(tcp[12]/16)):4]=0x5353482d"
 
 expected output
 
sudo iptables -A INPUT -p tcp -m bpf --bytecode "13,177 0 0 0,80 0 0 12,52 0 0 16,7 0 0 3,0 0 0 4,44 0 0 0,177 0 0 0,12 0 0 0,7 0 0 0,64 0 0 0,21 0 1 1397966893,6 0 0 1,6 0 0 0," -j LOG --log-prefix 'iptables-ssh-detected'
