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

# no7
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.218.4.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.218.4.2
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.218.4.2 -j DNAT --to-destination 192.218.0.14
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.218.4.2 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.218.4.2
iptables -A PREROUTING -t nat -p tcp --dport 80 -d 192.218.4.2 -j DNAT --to-destination 192.218.0.14
