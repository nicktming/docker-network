PREFIX=vxlan 
IP=172.19.0.8 
DESTIP=172.19.0.12
PORT=4789
VNI=1
SUBNETID=2
SUBNET=10.$VNI.$SUBNETID.0/24
VXSUBNET=10.$VNI.$SUBNETID.250/32
DEVNAME=$PREFIX.$VNI

ip link delete $DEVNAME 
ip link add $DEVNAME type vxlan id $VNI dev eth0 local $IP dstport $PORT nolearning
#echo '3' > /proc/sys/net/ipv4/neigh/$DEVNAME/app_solicit 
ip address add $VXSUBNET dev $DEVNAME 
ip link set $DEVNAME up 
#ip route add $SUBNET dev $DEVNAME scope global

