echo nameserver 192.218.0.6 >> /etc/resolv.conf

apt get update -y
apt get install isc-dhcp-relay -y
apt get install netcat

echo ‘net.ipv4.ip_forward=1’ > /etc/sysctl.conf

echo ‘ 
SERVER=”192.218.0.2”
INTERFACES=”eth0 eth1 eth2”
OPTIONS=””
‘ > /etc/default/isc-dhcp-relay

service isc-dhcp-relay restart
