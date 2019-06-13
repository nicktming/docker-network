ip link delet veth1 type veth
ip netns delete ns1
ip link delete br0 type bridge
iptables -t nat -F
iptables -F


ip link add br0 type bridge
ifconfig br0 10.1.1.1/24
ip link set br0 up

ip link add veth1 type veth peer name veth2
ip link set veth1 up
brctl addif br0 veth1
ip netns add ns1
ip link set veth2 netns ns1

ip netns exec ns1 ip addr add 10.1.1.2/24 dev veth2
ip netns exec ns1 ip link set lo up
ip netns exec ns1 ip link set veth2 up
ip netns exec ns1 route add default gw 10.1.1.1


#iptables -P FORWARD ACCEPT
iptables -P FORWARD DROP
iptables -t filter -A FORWARD -s 10.1.0.0/16 -j ACCEPT
iptables -t filter -A FORWARD -d 10.1.0.0/16 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.1.1.0/24 -o eth0 -j MASQUERADE

#iptables -t filter -A FORWARD -s 192.1.0.0/16 -j ACCEPT
#iptables -t filter -A FORWARD -d 192.1.0.0/16 -j ACCEPT

