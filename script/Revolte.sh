apt-get update -y
apt-get install isc-dhcp-server -y
﻿apt get install netcat

echo ‘
INTERFACESV4="eth0"
INTERFACESV6=’ > /etc/default/isc-dhcp-server

echo ‘
subnet 192.218.0.0 netmask 255.255.255.252 {
}

subnet 192.218.0.4 netmask 255.255.255.252 {
}
﻿
subnet 192.218.0.128 netmask 255.255.255.128 { 
range 192.218.0.131 192.218.0.254; 
option routers 192.218.0.129;
option broadcast-address 192.218.0.255; 
option domain-name-servers 192.218.0.6;
default-lease-time 180; 
max-lease-time 5760;
}

subnet 192.218.2.0 netmask 255.255.254.0 { 
range 192.218.2.2 192.218.3.254; 
option routers 192.218.2.1;
option broadcast-address 192.218.3.255; 
option domain-name-servers 192.218.0.6;
default-lease-time 180;
﻿	max-lease-time 5760;
}

subnet 192.218.0.8 netmask 255.255.255.252 {
}

subnet 192.218.0.12 netmask 255.255.255.252 {
}

subnet 192.218.0.16 netmask 255.255.255.252 {
}

subnet 192.218.0.20 netmask 255.255.255.252 {
}

subnet 192.218.8.0 netmask 255.255.248.0 { 
range 192.218.8.2 192.218.15.254;
option routers 192.218.8.1;
option broadcast-address 192.218.15.255; 
option domain-name-servers 192.218.0.6;
default-lease-time 180;
max-lease-time 5760;
}

﻿

subnet 192.218.4.0 netmask 255.255.252.0 { 
range 192.218.4.3 192.218.7.254; 
option routers 192.218.4.1;
option broadcast-address 192.218.7.255; 
option domain-name-servers 192.218.0.6;
default-lease-time 180; 
max-lease-time 5760;
}' > /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart

echo nameserver 192.218.0.6 >> /etc/resolv.conf
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
