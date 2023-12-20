iptables -t nat -A POSTROUTING -s 192.218.0.0/20 -o eth0 -j SNAT --to-source $(hostname -I | awk '{print $1}')

apt get update -y
apt get install isc-dhcp-relay -y

echo ‘net.ipv4.ip_forward=1’ > /etc/sysctl.conf

echo ‘ 
SERVER=”192.218.0.2”
INTERFACES=”eth0 eth1 eth2”
OPTIONS=””
‘ > /etc/default/isc-dhcp-relay

service isc-dhcp-relay restart
