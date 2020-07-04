#!/bin/bash
tcpdump -ddd $3 > num.txt
lines=`cat num.txt | wc -l`
tail -n "$((lines-7))" num.txt > num2.txt
lines=`cat num2.txt | wc -l`
head -n "$((lines-2))" num2.txt > num3.txt
cat num3.txt | sed -r 's/(^(177|80|72|64)( [0-9]{1,2}){2} )([0-9]{1,10})/echo "\1$((\4-14))"/ge' > num4.txt
echo "6 0 0 1:6 0 0 0" | tr ":" "\n" >> num4.txt
cat num4.txt | wc -l >> num5.txt
cat num4.txt >> num5.txt
cat num5.txt | tr "\n" "," | sed -r "s/^/iptables -A $1 -p $2 -m bpf --bytecode \"/g" | sed -r 's/$/" -j LOG/g'
echo ""
rm -f num5.txt
rm -f num4.txt
rm -f num3.txt
rm -f num2.txt
rm -f num.txt
