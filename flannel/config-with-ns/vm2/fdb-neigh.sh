ip route add 10.1.1.0/24 via 10.1.1.0 dev vxlan.1 onlink
bridge fdb add $1 dev vxlan.1 dst 172.19.0.12
#ip neighbor add 172.19.0.12 lladdr $1 dev vxlan.1
arp -s 10.1.1.0 $1 dev vxlan.1

