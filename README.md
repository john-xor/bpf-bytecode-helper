# bpf-bytecode-helper
converts tcpdump's output of -ddd to a bytecode iptables can understand and act on

usage
./tcpdump_conv.sh "iptables chain" "transport protocol" "bpf filter here"
  
 example for a window size of 29200
 ./tcpdump_conv.sh "INPUT" "tcp" "tcp[14:2]=29200"
 
 expected output
 iptables -A INPUT -p tcp -m bpf --bytecode "5,177 0 0 0,72 0 0 14,21 0 1 29200,6 0 0 1,6 0 0 0," -j LOG
