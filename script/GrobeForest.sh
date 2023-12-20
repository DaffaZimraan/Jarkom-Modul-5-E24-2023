apt-get update -y
apt-get install lynx -y
apt-get install apache2-utils -y
apt get install netcat

# no2 
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -j DROP
iptables -A INPUT -p udp -j DROP
